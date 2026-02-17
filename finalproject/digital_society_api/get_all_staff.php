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

$result = mysqli_query($conn, "SELECT id, name, role, created_at FROM staff ORDER BY id DESC");

if(!$result){
    response("error", "Query failed: " . mysqli_error($conn), []);
}

$staff = [];
while($row = mysqli_fetch_assoc($result)){
    $staff[] = $row;
}

response("success", "Staff fetched successfully", $staff);

$conn->close();
?>
