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

$base_url = "http://localhost/digital_society_api/uploads/events/";

$event_date = $_POST['event_date'] ?? '';

if ($event_date) {
    $q = "SELECT * FROM events WHERE event_date = '$event_date' ORDER BY event_date ASC";
} else {
    $q = "SELECT * FROM events ORDER BY event_date ASC";
}

$r = mysqli_query($conn, $q);

if (!$r) {
    response("error", "Query failed: " . mysqli_error($conn), []);
}

$data = [];

while ($row = mysqli_fetch_assoc($r)) {
    if (!empty($row['image'])) {
        $row['image_url'] = $base_url . $row['image'];
    } else {
        $row['image_url'] = null;
    }
    $data[] = $row;
}

if(count($data) > 0){
    response("success", "Events list", $data);
}else{
    response("success", "No events found", []);
}

$conn->close();
?>
