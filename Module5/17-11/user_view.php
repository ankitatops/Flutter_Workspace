<?php

    include('connect.php');

    $sql ="select * from ankita_user";
    $response = array();
    $res = mysqli_query($con,$sql);

    while($data = mysqli_fetch_array($res))
    {
    
        $row["name"]=$data["name"];
        $row["email"]=$data["email"];
        $row["mobile"]=$data["mobile"];
        $row["password"]=$data["password"];
    

        array_push($response,$row);


    }
    echo json_encode($response);



?>