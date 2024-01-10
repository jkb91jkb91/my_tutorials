import mysql.connector
import pika
import json
import sys
import memcache


name = sys.argv[1]

db_config = {
    "host": "sql",
    "user": "db_user",
    "password": "db_user_pass",
    "database": "db_database"
}

rmq_config = {
    "host": "my_rb",
    "user": "user",
    "password": "password",
    "port": "5672",
    "vh": "my_vhost"
}

connection = mysql.connector.connect(**db_config)
memcached_client = memcache.Client(['memcached:11211'], debug=0)

def create_queue_and_send_message(queue_name, message):
    credentials = pika.PlainCredentials(rmq_config['user'], rmq_config['password'])
    connection_params = pika.ConnectionParameters(
        host=rmq_config['host'],
        port=int(rmq_config['port']),
        virtual_host=rmq_config['vh'],
        credentials=credentials
    )
    connection = pika.BlockingConnection(connection_params)
    channel = connection.channel()
    channel.queue_declare(queue=queue_name)
    channel.basic_publish(exchange='', routing_key=queue_name, body=message)
    connection.close()

def consume_messages(queue_name):
    credentials = pika.PlainCredentials(rmq_config['user'], rmq_config['password'])
    connection_params = pika.ConnectionParameters(
        host=rmq_config['host'],
        port=int(rmq_config['port']),
        virtual_host=rmq_config['vh'],
        credentials=credentials
    )
    connection = pika.BlockingConnection(connection_params)
    channel = connection.channel()
    while True:
        method_frame, header_frame, body = channel.basic_get(queue=queue_name, auto_ack=True)
        if method_frame:
            formatted = body.decode('utf-8')
            print(formatted)
            add_to_database(formatted)
        else:
            print('Brak wiadomości w kolejce.')
            break  # Zakończ pętlę gdy kolejka jest pusta

    connection.close()

def save(name): 
    create_queue_and_send_message('moja_kolejka', name)
    consume_messages('moja_kolejka')
    

def add_to_database(name):
    cursor = connection.cursor()
    insert_query = "INSERT INTO imiona (name) VALUES (%s)"
    data = (name,)
    cursor.execute(insert_query, data)
    connection.commit()
    cursor.close()
    mem_key=f'login_{name}' 
    memcached_client.set(mem_key, name)


def get_names():
    cursor = connection.cursor()
    select_query = "SELECT name FROM imiona"
    cursor.execute(select_query)
    names = [row[0] for row in cursor.fetchall()]
    cursor.close()
    return names


# Wyciaganie z bazy danych
def get_name_from_database(search_name):
    mem_key=f'login_{search_name}'
    result = memcached_client.get(mem_key)
    if result:
        print("Fetched from Memcached")
        return result 
    
    print(result)
    cursor = connection.cursor()
    query = "SELECT * FROM imiona WHERE name = %s"
    cursor.execute(query, (search_name,))

    results = cursor.fetchall()
    cursor.close()
    return results
    if results:
        memcached_client.set(search_name, results[0])  # Zakładając, że interesuje nas tylko pierwszy wynik

    return results
    
    



print(get_name_from_database(name))
#save(name)
connection.close()

