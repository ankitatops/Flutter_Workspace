<?php
header('Content-Type: application/json');
include "../config/db.php";

function response($status, $message, $data = null){
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}

$result = mysqli_query($conn, "SELECT id, name, flat_no, visit_date, status, created_at FROM visitors ORDER BY visit_date DESC");

if(!$result){
    response("error", "Query failed: " . mysqli_error($conn), []);
}

$visitors = [];
while($row = mysqli_fetch_assoc($result)){
    $visitors[] = $row;
}

response("success", "Visitors fetched successfully", $visitors);

$conn->close();
?>
