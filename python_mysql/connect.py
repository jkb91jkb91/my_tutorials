import mysql.connector
#I accidentally installed mysql-connector instead of mysql-connector-python (via pip3).
# Just leaving this here in case it helps someone.

mydb = mysql.connector.connect(
    host='172.17.0.2',
    user='kuba',
    password='kuba',
    database='db',
    port=3306
)


print(mydb)

# cur = mydb.cursor()

# sql = "INSERT INTO pracownicy (name) VALUES (%s)"
# val = ("John",)
# cur.execute(sql, val)

# mydb.commit()

# print(cur.rowcount, "record inserted.")
