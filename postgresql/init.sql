-- Tworzenie bazy danych


DO $$ 
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'testing_db') THEN
        CREATE DATABASE testing_db;
    END IF;
END $$;


-- Użycie utworzonej bazy danych
\c testing_db;

-- Tworzenie tabeli
CREATE TABLE customers (firstname text, lastname text);

-- Wstawianie danych
INSERT INTO customers (firstname, lastname) VALUES ('BOB', 'Smith');
