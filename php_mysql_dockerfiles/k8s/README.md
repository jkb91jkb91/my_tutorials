
PRESTEP >> branch kubernetes > project with INGRESS

INGRESS+![first_screen](https://github.com/jkb91jkb91/my_tutorials/assets/32479224/8d2da287-a53f-49b4-9e5f-7fb488a33971)
Frontend(DEPLOYMENT+CLUSTER+IP) + backend(DEPLOYMENT+CLUSTER_IP) + VOLUME  





FOR NOW DATABASE DOESNT WORK FROM THE BEGINNING , this is the problem
Correct database here



Apply all files:
1.) kubectl apply -f ./



2.)kubectl get nodes -o wide

http://<NODE_IP>:30080


NAME       STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
minikube   Ready    control-plane   10m   v1.26.3   192.168.49.2   <none>        Ubuntu 20.04.5 LTS   6.1.55-1-MANJARO   docker://23.0.2


>>> http://192.168.49.2:30080






