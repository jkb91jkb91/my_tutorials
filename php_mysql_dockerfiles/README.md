LOCAL TESTING

used kubernetes NGINX
-install required command from official site
-add addon for minikube
-instead of NodePort for web frontend use ClusterIP
-create INGRESS that routes to ClusterIP(webApp)

>>> minikube IP  <<<< it will give you IP of minikube, use it with port of ClusterIP

