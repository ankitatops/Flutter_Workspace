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

$result = mysqli_query($conn, "SELECT id, name, phone, flat_no, email, image  FROM users ORDER BY id DESC");

if(!$result){
    response("error", "Query failed: " . mysqli_error($conn), []);
}

$users = [];
while($row = mysqli_fetch_assoc($result)){
    $users[] = $row;
}

response("success", "Users fetched successfully", $users);
$conn->close();
?>
