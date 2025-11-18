<?php

    include('connect.php');

    $id = $_POST['id'];
    $p_name = $_POST['p_name'];
    $p_price = $_POST['p_price'];
    $p_des = $_POST['p_des'];
   

    if($id=="" && $p_name=="" && $p_price=="" && $p_des=="")
    {
        echo '0';
    }
    else
    {
        $sql = "insert into ankita_products (id,p_name,p_price,p_des)values('$id','$p_name','$p_price','$p_des')";
        mysqli_query($con,$sql);
    }

?>