<?php

    include('connect.php');

    $upload_path = 'images/';

     $upload_url = 'https://'.$_SERVER['SERVER_NAME'] . "/API/" . $upload_path;


    $p_name = $_REQUEST['p_name'];
    $p_price = $_POST['p_price'];
    $p_des = $_POST['p_des'];
    

    $fileinfo = pathinfo($_FILES["p_img"]["p_name"]);

    $extension = $fileinfo["extension"];

    $random = 'image_' . rand(1000,9999);


    $file_url = $upload_url . $random . '.' . $extension;


    $file_path = $upload_path . $random . '.'. $extension;

   move_uploaded_file($_FILES["p_img"]["tmp_name"],$file_path);
   

   $sql = "INSERT INTO  ankita_products(p_name,p_price,p_des,p_img) VALUES ('$p_name','$p_price','$p_des','$file_url')";

  mysqli_query($con, $sql);

    mysqli_close($con);



?>