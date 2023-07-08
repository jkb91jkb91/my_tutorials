import mysql.connector
#Install via pip3 > pip3 install mysql-connector-python
#I accidentally installed mysql-connector instead of mysql-connector-python (via pip3).
# Just leaving this here in case it helps someone.

#Run docker container, root,root, kuba,kuba
#docker run --name dockermysqlcontainer -e MYSQL_ROOT_PASSWORD=root -e MYSQL_USER=kuba -e MYSQL_PASSWORD=kuba -d mysql:latest

#Jesli ten kod nie zadziala i nie wystawi portu tu uzyj czegos takiego
#docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_USER=kuba -e MYSQL_PASSWORD=kuba -p 3307:3306 -d mysql:tag


# Test container if you can log in into ( IP is just an example of the container)
#mysql -h 172.17.0.2 -u kuba -p --port=3306

# Ponizsze wykonaj z roota
# Create db schema database=db, table=pracownicy, grant all privileges to user kuba, flush all privileges

# CREATE DATABASE db;

# USE db;

# CREATE TABLE pracownicy (
#     id INT AUTO_INCREMENT PRIMARY KEY,
#     imie VARCHAR(255) NOT NULL,
#     nazwisko VARCHAR(255) NOT NULL,
#     wiek INT NOT NULL
# );

# GRANT ALL PRIVILEGES ON db.* TO 'kuba'@'localhost' IDENTIFIED BY 'kuba';


#INSERT INTO pracownicy (imie, nazwisko, wiek) VALUES ('kuba', 'g', '25');
#SELECT * FROM pracownicy;

#PYTHON

mydb = mysql.connector.connect(
    host='172.17.0.2',
    user='kuba',
    password='kuba',
    database='db',
    port=3306
)

#print(mydb)
mycursor = mydb.cursor()

sql = "INSERT INTO pracownicy (imie, nazwisko, wiek) VALUES (%s, %s, %s)"
val = ("John1", "Doe", 30)
mycursor.execute(sql,val)

mydb.commit()

print("record inserted.")

