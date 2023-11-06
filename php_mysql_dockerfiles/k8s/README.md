PROBLEM > IMAGE HAS NOT init file in it



NODEPORT+Frontend(DEPLOYMENT+CLUSTER_IP) + backend(DEPLOYMENT+CLUSTER_IP)


Important infos
-Login to DOCKER
-Prepare IMAGES and push to docker

1. docker-compose uses services called 
-app
-sql (this is used as DNS in app) > use metadada: name: sql

 apiVersion: v1
  2 kind: Service
  3 metadata:
  4   name: sql
  5 spec:
  6   type: ClusterIP
  7   selector:
  8     component: mysql
  9   ports:
 10     - port: 3306
 11       targetPort: 3306




Apply all files:
kubectl apply -f ./


How to start minikube nodePort app in browser



minikube service frontend-nodeport-service
