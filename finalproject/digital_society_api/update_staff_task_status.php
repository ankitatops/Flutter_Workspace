<?php
header('Content-Type: application/json');
include "config/db.php";

function response($status, $message, $data=[]){
    echo json_encode([
        "status"=>$status,
        "message"=>$message,
        "data"=>$data
    ]);
    exit;
}

$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
$status = isset($_POST['status']) ? $_POST['status'] : '';

if(!$id || !$status) response("error","Task ID and status required");

$q = "UPDATE staff_tasks SET status='$status' WHERE id=$id";

if(mysqli_query($conn, $q)){
    response("success","Staff task status updated",["id"=>$id]);
}else{
    response("error","Update failed");
}

mysqli_close($conn);
?>
