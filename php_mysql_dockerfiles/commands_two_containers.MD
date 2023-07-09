
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



