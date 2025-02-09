 
# 1 Instalacja container registry zgodnie z dokumentacja
# 2 Accept EULA  
# 3 Debugging  


PREREQUISUITES CLOUD  
-UNBLOCK PORT artifactory:8081/8082  
-5432 < postgres  

JESLI CHCESZ SIE ZALOGOWAC NA HTTP DOCKEREM MUSISZ DODAC INSECURE REGISTRIES DO CELOW TESTOWYCH  
sudo nano /etc/docker/daemon.json  >> IP maszyny 34.68.19.150  
```
{
  "insecure-registries": ["34.68.19.150:8082"]
}
```
docker info | grep -i "insecure registries"  
```
 Insecure Registries:
```

# 1 Instalacja container registry zgodnie z dokumentacja
https://jfrog.com/download-jfrog-container-registry/ # tutaj pobierajac docker-compsose >> wejdz w NEtwork i pod 302 znajdziesz link, ktory zostal uzyty ponizej  
```
wget -O jfrog-container.tar https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/jcr/docker/jfrog-artifactory-jcr/[RELEASE]/jfrog-artifactory-jcr-[RELEASE]-compose.tar.gz?_gl=1*c39zeb*_gcl_au*NTk4MTUyMTg1LjE3Mzg1OTE1NzM.*FPAU*NTk4MTUyMTg1LjE3Mzg1OTE1NzM.*_ga*MTE3MzcwMzk4Mi4xNzM4NTg0NDYw*_ga_SQ1NR9VTFJ*MTczOTEwMTM4My45LjEuMTczOTEwMTQ5MC4wLjAuMTY1NzIwOTUwMQ..*_fplc*ZlRLMEh1a2ZzYSUyQkJSc1psbmdqdTdWcUhpRmolMkJDQ0xyd0hkZGNzWjEyRXl1cm1ScHlXS0paYlI2aGFSUlZSNGtGOXpUMGlRZzJWQWVIUncyMDJQQWRocnRacXlIJTJGT3hJa0ZmNXNjcU9NYjIlMkJUMjVYb0ZmdWtONXlTcHBJdkElM0QlM0Q.
```
```
tar -xf jfrog-container.tar
```

Dostaniemy taki folder >> artifactory-jcr-7.104.6  oraz takie pliki  
```
README.md  bin  config.sh  templates  third-party
```

KOMENDA
```
sudo ./config.sh
```
```
Installation Directory (Default: /root/.jfrog/artifactory): 
```

FOR QUICK SETUP
```
Do you want to install PostgreSQL? [Y/n]: N
Enter database type, supported values [ postgresql mssql mariadb mysql oracle derby ]: derby
start:               docker compose -p rt up -d
```


ZEBY ODPALIC docker-compose dla artifactory BAZA DANYCH MUSI BYC POSTAWIONA WCZESNIEJ I MUSI JUZ STAC

# 2 Accept EULA  
```
ArtifactoryURL=http://34.68.19.150:8082
curl -XPOST -vu admin:password ${ArtifactoryURL}/artifactory/ui/jcr/eula/accept
```
# 2 Debugging  
```
curl -u admin:password "http://34.68.19.150:8082/artifactory/api/system/ping"
```
```
docker logs artifactory --tail 50
```
```
OKjakub_g26101991@gitlab:~curl -u admin:password "http://34.68.19.150:8082/artifactory/api/docker/kuba-docker-local/v2/_catalog"g"
{
  "errors" : [ {
    "status" : 503,
    "message" : "status code: 503, reason phrase: In order to use Artifactory you must accept the EULA first"
  } ]
}
```
