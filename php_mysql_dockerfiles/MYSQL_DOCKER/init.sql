USE test1;

CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(250) NOT NULL,
  email VARCHAR(250) UNIQUE,
  phone VARCHAR(100),
  bgroup VARCHAR(100)
);