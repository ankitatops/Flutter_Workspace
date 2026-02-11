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

$q = "SELECT * FROM events ORDER BY event_date ASC";
$r = mysqli_query($conn, $q);

if (!$r) {
    response("error", "Query failed: " . mysqli_error($conn), []);
}

$data = [];

while ($row = mysqli_fetch_assoc($r)) {
    $data[] = $row;
}

if(count($data) > 0){
    response("success", "Events list", $data);
}else{
    response("success", "No events found", []);
}

$conn->close();
?>
