#CONFIG ZNAJDUJE SIE W kind-config.yaml

# START KIND with 1 master + 2 workers
kind create cluster --name multiworker --config kind-config.yaml

# How to ssh to worker
docker exec -it WORKER_NAME bash

# How to list kind clusters
kind get clusters

# How to delete clusters
kind delete cluster --name YOUR_CLUSTER_NAME





kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

