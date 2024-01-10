create db test1

Name users , number of columns 5


id INT
name VARCHAR   Length 250
email VARCHAR  Length 250
phone VARCHAR  Length 100
bgroup VARCHAR Length 100







<?php
$user = "kuba";
$password = "kuba";
$database = "test1";
$table = "users";

// Nawiązanie połączenia z bazą danych
$conn = new mysqli("localhost", $user, $password, $database);

// Sprawdzenie połączenia
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Connected successfully";
}

#$id = 4; // id powinno być liczbowe
$name = 'bartek';
$email = 'kudlaty@gmail.com';
$phone = '343343';
$bgroup = '0+';

// Utworzenie polecenia SQL do dodania danych do tabeli users
$sql = "INSERT INTO users(name, email, phone, bgroup) VALUES ('$name', '$email', '$phone', '$bgroup')";




$sql = "SELECT * FROM users";
$result = mysqli_query($conn, $sql); // wykonanie zapytania

if ($result) {
  while ($row = mysqli_fetch_assoc($result)) { // pobieranie wyników jako tablicy asocjacyjnej
    echo $row['id'] . " " . $row['name'] . " " . $row['email'] . " " . $row['phone'] . " " . $row['bgroup'] . "<br>"; // wyświetlanie danych z każdego wiersza
  }
} else {
  echo "Błąd podczas wykonywania zapytania: " . mysqli_error($conn);
}


if (mysqli_query($conn, $sql)) {
  echo "git";
} else {
  echo "Błąd podczas dodawania rekordu: " . mysqli_error($conn);
}

$stmt->close();
$conn->close();
?>
