<?php
header('Content-Type: application/json');
include "config/db.php";

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

$imageName = "";

if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {

    $targetDir = "../uploads/events/";

    $imageName = time() . "_" . basename($_FILES["image"]["name"]);
    $targetFile = $targetDir . $imageName;

    move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile);
}

$q = "INSERT INTO events (title, description, event_date, image)
      VALUES ('$title', '$desc', '$date', '$imageName')";

if (mysqli_query($conn, $q)) {
    response("success", "Event created successfully");
} else {
    response("error", "Event creation failed");
}

mysqli_close($conn);
?>
