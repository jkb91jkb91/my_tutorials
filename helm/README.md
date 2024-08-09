# TIP1 po zrobieniu helm create usuwaj /templates bo blad wyskoczy
# w value.yaml na najnwyzsym poziomie musi byc nazwa folderu charts/nginx to wtedy bedziesz mial nginx
# jak sprawdzic czy pody flux dzialaja >> kubectl get pods -n flux-system
# TIP 4 Jak sprawdzic czy FLUX widzi REPO >> kubectl get gitrepositories -A
# TIP 5 jesli helm file wstawiasz np do staging to musisz miec juz utworzony ten namespace
# TIP 6 pamietaj ze Kustomization tez musi dzialac >> kubectl get kustomizations -A
# JAK TESTOWAC FLUXA
# na poczatku odpalasz values.yaml na najwyzszym poziomie helm template . -f values.yaml
# nastepnie wrzucasz wartosci do HelmRelease i testujesz to tak >>> k apply -f ADRES_RELEASEA , to i tak zostanie przez Fluxa wyjebane po 10 minutach czy ilus tam


# Dokument opisujacy stawianie jenkinsa z helmem
https://docs.google.com/document/d/1LEd5tayTqqe-6_9hQ9WD_OxJh-ChLqvM6jmcxXbIKOc/edit

helm install NAME_OF_INSTALLATION REPO_NAME # helm install my-nginx bitnami/nginx  
helm install my-installation ./jenkins  
helm pull  
helm search repo nginx  
helm search repo --versions nginx  

helm search repo --versions "nginx"  


# Helm get notes
helm get notes releasename


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
Po wszystkim usun co niepotrzebne  
Do folderu charts pobierz interesujacy cie chart np jenkinsa  
helm create my_jenkins_chart  


# Testowanie template lub --dry-run
helm template . -f values.yaml
helm install REALASENAME FILES --dry-run

# Szybki update jakiejs wartosci za pomoca set
helm upgrade graf --set adminUser=bartek .
