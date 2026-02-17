<?php
$conn = mysqli_connect("localhost","root","","digital_society");

if(!$conn){
    echo json_encode([
        "status" => "error",
        "message" => "Database connection failed"
    ]);
    exit;
}
?>
