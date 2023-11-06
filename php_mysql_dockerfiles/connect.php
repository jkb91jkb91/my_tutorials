

<?php

    if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) {
        $conn = mysqli_connect('sql', 'root', 'root', 'test1', '3306') or die("Connection Failed:" . mysqli_connect_error());

        if (isset($_POST['name']) && isset($_POST['email']) && isset($_POST['phone']) && isset($_POST['bgroup'])) {
            $name = $_POST['name'];
            $email = $_POST['email'];
            $phone = $_POST['phone'];
            $bgroup = $_POST['bgroup'];

            $sql = "INSERT INTO `users` (`name`, `email`, `phone`, `bgroup`) VALUES ('$name','$email','$phone','$bgroup')";

            $query = mysqli_query($conn, $sql);

            if ($query) {
                echo '2Entry Successful<br>';

                // Here we fetch and print the names
                $names = fetchNames($conn);
                foreach ($names as $name) {
                    echo $name . "<br>";
                }

            } else {
                echo "Entry failed.";
            }
        }
    }

    function fetchNames($conn) {
        $sql = "SELECT `name` FROM `users`";
        $query = mysqli_query($conn, $sql);

        $names = [];
        while ($row = mysqli_fetch_assoc($query)) {
            $names[] = $row['name'];
        }

        return $names;
    }

?>

