<?php
header('Content-Type: application/json');
include "connect.php";

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

if (!isset($_FILES['image']) || $_FILES['image']['error'] != 0) {
    response("error", "Image file required");
}

$folder = "uploads/events/";

if (!is_dir($folder)) {
    mkdir($folder, 0777, true);
}

$imageName = time() . "_" . basename($_FILES['image']['name']);
$file_path = $folder . $imageName;

if (move_uploaded_file($_FILES['image']['tmp_name'], $file_path)) {

 $upload_url = 'https://'.$_SERVER['SERVER_NAME'] . "/ankita/" . $file_path;
   

    $q = "INSERT INTO events (title, description, event_date, image)
          VALUES ('$title', '$desc', '$date', '$imageName')";

    if (mysqli_query($conn, $q)) {
        response("success", "Event created successfully", [
            "image" => $file_path
        ]);
    } else {
        response("error", "Event creation failed");
    }

} else {
    response("error", "Failed to upload image");
}

mysqli_close($conn);
?>