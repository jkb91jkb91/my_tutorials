

Use test1;

CREATE TABLE IF NOT EXISTS  users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(250) NOT NULL,
  email VARCHAR(250) UNIQUE,
  phone VARCHAR(100),
  bgroup VARCHAR(100)
);

INSERT INTO users (name, email) VALUES ('Test User', 'test@example.com');
