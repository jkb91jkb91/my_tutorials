<?php




    $db_name = getenv('MYSQL_DATABASE');
    $db_user = getenv('MYSQL_USER');
    $db_password = getenv('MYSQL_PASSWORD');


    if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) {
        $conn= mysqli_connect('mysql', $db_user, $db_password , $db_name , '3306') or die("Connection Failed:" .mysqli_connect_error());
        if(isset($_POST['name']) && isset($_POST['email']) && isset($_POST['phone']) && isset($_POST['bgroup'])) {
            $name= $_POST['name'];
            $email= $_POST['email'];
            $phone= $_POST['phone'];
            $bgroup= $_POST['bgroup'];

            $sql= "INSERT INTO `users` (`name`, `email`, `phone`, `bgroup`) VALUES ('$name','$email','$phone','$bgroup')";

            $query = mysqli_query($conn,$sql);
            if($query) {
                echo 'Entry Successful';
            }
            else {
                echo "not";
            }
        }
    }
?>
