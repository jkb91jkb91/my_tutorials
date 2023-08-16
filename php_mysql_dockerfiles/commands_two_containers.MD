
#MYSQL container

docker run -p 3306:3306 --name mysql_php -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=test1 -d mysql:5.7
docker exec -it mysql_php bash
mysql -u root -proot
Use test1;
g 172.17.0.3. Set the 'ServerName' directive globally to suppress this message
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(250) NOT NULL,
  email VARCHAR(250) UNIQUE,
  phone VARCHAR(100),
  bgroup VARCHAR(100)
);
docker inspect mysql_php | grep IPAdress   #172.17.0.2
docker exec -it mysql_php bash
mysql -u root -proot
SELECT * FROM users;


#apache container  jest to kontener z zainstalowanym juz lampem
# folder glowny tu gdzie wkladamy pliki jest pod /app

docker run -d -p 80:80 --name lamp mattrayner/lamp:latest
docker inspect lamp | grep IPAdress   #172.17.0.3
docker cp /connect.php lamp:/usr/local/apache2/htdocs
apachectl -k restart


How to run

WEBAPP
1. Create image from DockerFile sql
docker built -t web .
2. Check if created > docker images
3. docker run -d -p 80:80 --name weblamp  web

DATABASE

1. Create image from DockerFile sql
docker build -t sql .
do
docker build -f Dockerfile -t database . 
2.Run COntainer this way >> docker run -p 3306:3306 --name mysql_container -e MYSQL_ROOT_PASSORD=root -e MYSQL_DATABASE=test1 -d sql

3.docker inspect DATABASECONTAINER  << check IP

3. Go to WEBAPP and in connect.php replace IP for database
4.Reload apache /etc/init.d/apache2 reload


HOW TO USE INSTEAD OF IP ADRESS JUST NAME OF CONTAINER

1.) launch web container and edit /etc/hosts
in /etc/host add IP of sql container WITH NAME OF THIS container ex >> 172.17.05 mys
2.) and change the address of the server 
   conn= mysqli_connect('172.17.0.5', 'root', 'root' , 'test1' , '3306') or die("Connection Failed:" .mysqli_connect_error());
   conn= mysqli_connect('mys', 'root', 'root' , 'test1' , '3306') or die("Connection Failed:" .mysqli_connect_error());
 
