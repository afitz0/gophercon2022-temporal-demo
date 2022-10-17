#!/usr/bin/env bash

mkdir logs
echo "building..."
make proto >> logs/build.log

echo "starting temporalite..."
temporalite start --namespace default --ephemeral >> logs/temporalite.log &
pid[0]=$!

echo "starting node api..."
( cd api; npm run serve ) >> logs/node-api.log &
pid[1]=$!

echo "starting temporal worker..."
( cd temporal; go run worker/main.go ) >> logs/temporal-worker.log &
pid[2]=$!

echo "starting flutter frontend..."
( cd frontend; flutter run -d macos --web-renderer html ) >> logs/flutter-ui.log &
pid[3]=$!

echo "waiting for all. temporal ui should be at http://localhost:8233/"
echo "ctrl-c to term everything. check ./logs for logs"
trap "kill ${pid[0]} ${pid[1]} ${pid[2]} ${pid[3]}; exit 1" INT
wait
