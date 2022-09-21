# GopherPizza

Temporal demo application, originally designed and written for GopherCon 2022 in Chicago.

There are three components to this app:

1. Temporal workflow, representing the process for ordering a pizza
1. Typescript, Node, Express service to intermediate between Temporal and the UI
1. UI, currently in Flutter

## Building and running

This was developed with the following on macos:
* go v1.18.4
* node v16.16.0 and tsc v4.8.3
* flutter v3.3.2 and dart v2.18.1 on device: macos
* proto3 and libprotoc v3.20.1
* temporalite v1.17.3

To build and run:
1. `make proto`
1. `temporalite start --namespace default`
1. `cd api; npm run serve`
1. `cd temporal; go run worker/main.go`
1. `cd frontend; flutter run -d macos`

Alternatively, see ./run_all.sh
