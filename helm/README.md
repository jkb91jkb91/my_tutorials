# Dokument opisujacy stawianie jenkinsa z helmem
https://docs.google.com/document/d/1LEd5tayTqqe-6_9hQ9WD_OxJh-ChLqvM6jmcxXbIKOc/edit

helm install NAME_OF_INSTALLATION REPO_NAME # helm install my-nginx bitnami/nginx
helm install my-installation ./jenkins
helm pull
helm search repo nginx
helm search repo --versions nginx

helm search repo --versions "nginx"

# Instalacja konkretnej wersji
helm install nginx02 --version 18.1.3 -n default

# Sprawdzanie zainstalowanych helmow
helm ls            #current namespace
helm ls -n default #default namespace


# HOW TO MODIFY VALUES > 2 options
1.) by changinx values.yaml file
2.)

# Instalacja Helm Chartu z wlasnym values do nadpisania
helm install nginx03 --values values_nginx.yaml ./nginx/

# Jak sprawdzic computed values jak zostaly uzyte
helm get values HELM_NAME_RELEASE -a

# Instalacja wlasnego charta
# Po wszystkim usun co niepotrzebne
# Do folderu charts pobierz interesujacy cie chart np jenkinsa
helm create my_jenkins_chart


# Testowanie 
helm template . -f values.yaml
