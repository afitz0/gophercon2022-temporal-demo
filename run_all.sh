#!/usr/bin/env bash

DO_K8S=0
if [ "$1" == "k8s" ]; then
    echo "Ok. Will setup Temporal workers in a kubernetes cluster"
    DO_K8S=1
fi

export NODE_PORT=8111
export FRONT_PORT=8222
export TMPRL_UI_PORT=8333
LOG_PATH=$(pwd)/logs

function cleanup() {
    echo -e "Stopping everything, please wait...\n"
    if [ $DO_K8S -eq 1 ]; then
        kubectl delete -f temporal/k8s-worker.yaml 2>&1 >> $LOG_PATH/k8s-worker.log
        minikube stop
        for e in $(minikube -p minikube docker-env 2>&1 | sed -e 's/export \([A-Z_]*\)=.*/\1/g' -e '/#.*/d'); do
            unset $e
        done
    fi

    for i in ${images[@]}; do
        docker stop -t 1 $i > /dev/null
    done

    for p in ${pid[@]}; do
        kill $p
    done
    exit 0
}

mkdir $LOG_PATH 2> /dev/null
echo "building..."
make all >> $LOG_PATH/build.log

echo "starting temporalite..."
temporalite start --ui-port $TMPRL_UI_PORT --namespace default --ephemeral >> $LOG_PATH/temporalite.log &
pid[0]=$!

echo "starting node api image..."
images[0]=$(docker run --detach -e PORT=80 -p ${NODE_PORT}:80 gopher-pizza/node-api)

echo "starting frontend image..."
images[1]=$(docker run --detach -e PORT=80 -p ${FRONT_PORT}:80 gopher-pizza/frontend)

if [ $DO_K8S -eq 1 ]; then
    minikube status &> /dev/null
    if [ $? -ne 0 ]; then
        echo "starting minikube..."
        minikube start 2>&1 >> $LOG_PATH/minikube.log
        if test $? -ne 0; then echo "Failed to start minikube"; exit 1; fi
    fi
fi

echo "bringing up temporal workers..."
if [ $DO_K8S -eq 1 ]; then
    eval $(minikube -p minikube docker-env)
    echo -e "\trebuilding temporal workers for minikube..."
    make docker-worker
    echo -e "\tapplying k8s deployment"
    kubectl apply -f temporal/k8s-worker.yaml 2>&1 | tee -a $LOG_PATH/k8s-worker.log
    if test $? -ne 0; then echo "Failed to kubectl apply workers"; exit 1; fi
else
    images[2]=$(docker run --detach gopher-pizza/temporal-worker)
fi

echo "Done. Here's where everything should be:"
echo -e "\tFrontend: http://localhost:$FRONT_PORT"
echo -e "\tTemporal UI: http://localhost:$TMPRL_UI_PORT"
echo -e "\tNode server (hopefully not needed): http://localhost:$NODE_PORT"
echo
echo "ctrl-c will kill most things."

trap cleanup INT
wait

exit 0
