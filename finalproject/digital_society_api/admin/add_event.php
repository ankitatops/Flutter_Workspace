<?php
header('Content-Type: application/json');
include "../config/db.php";

function response($status, $message, $data = [])
{
    echo json_encode([
        "status"  => $status,
        "message" => $message,
        "data"    => $data
    ]);
    exit;
}

$title = $_POST['title'] ?? '';
$desc  = $_POST['description'] ?? '';
$date  = $_POST['event_date'] ?? '';

if (!$title || !$desc || !$date) {
    response("error", "Title, description and date required");
}

$q = "INSERT INTO events (title, description, event_date)
      VALUES ('$title', '$desc', '$date')";

if (mysqli_query($conn, $q)) {
    response("success", "Event created successfully");
} else {
    response("error", "Event creation failed");
}
