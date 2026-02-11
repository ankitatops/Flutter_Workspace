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

$result = mysqli_query($conn, "SELECT * FROM visitors ORDER BY visit_date DESC");

if(!$result){
    response("error", "Query failed: " . mysqli_error($conn), []);
}

$visitors = [];
while($row = mysqli_fetch_assoc($result)){
    $visitors[] = $row;
}

if(count($visitors) > 0){
    response("success", "Visitors fetched successfully", $visitors);
}else{
    response("success", "No visitors found", []);
}

$conn->close();
?>
