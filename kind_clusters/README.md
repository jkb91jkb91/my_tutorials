
# START KIND with 1 master + 2 workers
kind create cluster --name multiworker --config kind-config.yaml

# How to ssh to worker
docker exec -it WORKER_NAME bash
