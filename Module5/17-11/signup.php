<?php

    include('connect.php');

   $id = $_POST['id'];
   $name = $_POST['name'];
   $email = $_POST['email'];
   $mobile = $_POST['mobile'];
   $pass = $_POST['password'];

    if($id=="" && $name=="" && $email== "" && $mobile=="" && $pass=="" )
    {
        echo '0';
    }
    else
    {
        $sql = "insert into ankita_user (id,name,email,mobile,password)values('$id','$name','$email','$mobile','$pass')";
        mysqli_query($con,$sql);
    }

?>