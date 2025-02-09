 
# 1 INSTALLATION JFROG CONTAINER REGISTRY (ACCORDING TO OFFICIAL DOCUMENTATION)  DOCKER-COMPOSE  
https://jfrog.com/download-jfrog-container-registry/  
# 2 ACCEPT EULA  
# 3 CREATE EXAMPLE DOCKER REGISTRY
# 4 LOGIN TO DOCKER REGISTRY  
# 5 PUSH SIMPLE ALPINE IMAGE  
# 6 DOWNLOAD IMAGE  
# 7 DELETE IAMGE WITH CURL
# 8 DEBUGGING     

 


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

# 1 INSTALLATION JFROG CONTAINER REGISTRY (ACCORDING TO OFFICIAL DOCUMENTATION) 
https://jfrog.com/download-jfrog-container-registry/ # tutaj pobierajac docker-compsose >> wejdz w NEtwork i pod 302 znajdziesz link, ktory zostal uzyty ponizej  
```
wget -O jfrog-container.tar https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/jcr/docker/jfrog-artifactory-jcr/[RELEASE]/jfrog-artifactory-jcr-[RELEASE]-compose.tar.gz?_gl=1*c39zeb*_gcl_au*NTk4MTUyMTg1LjE3Mzg1OTE1NzM.*FPAU*NTk4MTUyMTg1LjE3Mzg1OTE1NzM.*_ga*MTE3MzcwMzk4Mi4xNzM4NTg0NDYw*_ga_SQ1NR9VTFJ*MTczOTEwMTM4My45LjEuMTczOTEwMTQ5MC4wLjAuMTY1NzIwOTUwMQ..*_fplc*ZlRLMEh1a2ZzYSUyQkJSc1psbmdqdTdWcUhpRmolMkJDQ0xyd0hkZGNzWjEyRXl1cm1ScHlXS0paYlI2aGFSUlZSNGtGOXpUMGlRZzJWQWVIUncyMDJQQWRocnRacXlIJTJGT3hJa0ZmNXNjcU9NYjIlMkJUMjVYb0ZmdWtONXlTcHBJdkElM0QlM0Q.
```
```
tar -xf jfrog-container.tar $$ cd artifactory-jcr-7.104.6
```

Dostaniemy taki folder >> artifactory-jcr-7.104.6  oraz takie pliki  
```
README.md  bin  config.sh  templates  third-party
```
TWORZYMY FOLDER GDZIE BEDA PLIKI ARTIFACTORY
```
mkdir jfrog-dir
sudo chown -R 1030:1030 jfrog-dir
sudo chmod -R 700 jfrog-dir
```
KOMENDA
```
sudo ./config.sh
```
```
jakub_g26101991@gitlab:~/artifactory-jcr-7.104.6$ sudo ./config.sh 


Beginning JFrog Artifactory setup


Validating System requirements

Installation Directory (Default: /root/.jfrog/artifactory): /home/jakub_g26101991/jfrog-dir

Running system diagnostics checks, logs can be found at [/home/jakub_g26101991/artifactory-jcr-7.104.6/systemDiagnostics.log]
[ERROR] Ulimit level for open files is less than the recommended minimum 32000

[WARN] One or more system diagnostic checks have failed, check [/home/jakub_g26101991/artifactory-jcr-7.104.6/systemDiagnostics.log] for additional details

Triggering migration script. This will migrate if needed and may take some time.

Migration logs will be available at [/home/jakub_g26101991/artifactory-jcr-7.104.6/bin/migration.log]. The file will be archived at [/home/jakub_g26101991/jfrog-dir/var/log] after installation

For IPv6 address, enclose value within square brackets as follows : [<ipv6_address>]
Please specify the IP address of this machine (Default: 10.128.0.4): 34.68.19.150

Are you adding an additional node to an existing product cluster? [y/N]: n

The installer can install a PostgreSQL database, or you can connect to an existing compatible PostgreSQL database
(https://jfrog.com/help/r/jfrog-installation-setup-documentation/requirements-matrix)
If you are upgrading from an existing installation, select N if you have externalized PostgreSQL, select Y if not.
Do you want to install PostgreSQL? [Y/n]: y

To setup PostgreSQL, please enter a password
database password: 

confirm database password: 

[WARN] Confirmed database password doesn't match

To setup PostgreSQL, please enter a password
database password (****): 

confirm database password: 

Creating third party directories (if necessary)

Attempting to seed PostgreSQL. This may take some time.

Successfully seeded PostgreSQL

Docker setup complete

Installation directory: [/home/jakub_g26101991/jfrog-dir] contains data and configurations.

Use docker-compose commands to start the application. Once the application has started, it can be accessed at [http://10.128.0.4:8082]

Examples:
cd /home/jakub_g26101991/artifactory-jcr-7.104.6


start postgresql:    docker compose -p rt-postgres -f docker-compose-postgres.yaml up -d
stop  postgresql:    docker compose -p rt-postgres -f docker-compose-postgres.yaml down
start:               docker compose -p rt up -d
stop:                docker compose -p rt down

NOTE: The compose file uses several environment variables from the .env file. Remember to run from within the [/home/jakub_g26101991/artifactory-jcr-7.104.6] folder

Done
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

# 2 ACCEPT EULA 
```
ArtifactoryURL=http://34.68.19.150:8082
curl -XPOST -vu admin:password ${ArtifactoryURL}/artifactory/ui/jcr/eula/accept
```
```
jakub_g26101991@gitlab:~$ curl -XPOST -vu admin:password ${ArtifactoryURL}/artifactory/ui/jcr/eula/accept
*   Trying 34.68.19.150:8082...
* Connected to 34.68.19.150 (34.68.19.150) port 8082
* Server auth using Basic with user 'admin'
> POST /artifactory/ui/jcr/eula/accept HTTP/1.1
> Host: 34.68.19.150:8082
> Authorization: Basic YWRtaW46cGFzc3dvcmQ=
> User-Agent: curl/8.5.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Content-Length: 0
< Date: Sun, 09 Feb 2025 13:35:43 GMT
< Sessionvalid: false
< X-Artifactory-Id: 6d1731817a707a2f:-416a877d:194eae4b80d:-8000
< X-Artifactory-Node-Id: gitlab.us-central1-c.c.gitlab-449514.internal
< X-Jfrog-Version: Artifactory/7.104.6 80406900
< 
```

# 3 CREATE EXAMPLE DOCKER REGISTRY
>>> http://34.68.19.150:8082/ui/admin/repositories/local  
Utworz kuba-docker-local  

# 4 LOGIN TO DOCKER REGISTRY 
```
docker login 34.68.19.150:8082 -u 'admin' -p'password'
```
# 5 PUSH SIMPLE ALPINE IMAGE
```
docker pull alpine
docker tag alpine:latest 34.68.19.150:8082/kuba-docker-local/alpine:latest
docker push 34.68.19.150:8082/kuba-docker-local/alpine
```

# 6 DOWNLOAD IMAGE
```
docker pull 34.68.19.150:8082/kuba-docker-local/alpine:latest
```
# 7 DEBUGGING    
```
curl -u admin:password "http://34.68.19.150:8082/artifactory/api/system/ping"
```
```
docker logs artifactory --tail 50
```
Remove all unused containers
```
docker container prune -f
```
