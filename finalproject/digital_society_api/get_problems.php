<?php
header('Content-Type: application/json');
include "config/db.php";

function response($status, $message, $data = null){
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}

$q = "SELECT * From problems order by id desc";

$r = mysqli_query($conn, $q);

if(!$r){
    response("error", "Query failed: " . mysqli_error($conn), []);
}

$data = [];
while($row = mysqli_fetch_assoc($r)){
    $data[] = $row;
}

response("success", "Problems list fetched successfully", $data);

$conn->close();
?>
