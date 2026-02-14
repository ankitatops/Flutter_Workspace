<?php
header('Content-Type: application/json');

include "../config/db.php";

/* ---------- Response Function ---------- */
function response($status, $message, $data = [])
{
    echo json_encode([
        "status"  => $status,
        "message" => $message,
        "data"    => $data
    ]);
    exit;
}

$title   = $_POST['title'] ?? '';
$message = $_POST['message'] ?? '';


if (empty($title) || empty($message)) {
    response("error", "Title and message required");
}

$q = "INSERT INTO notices (title, message)
      VALUES ('$title', '$message')";

if (mysqli_query($conn, $q)) {
    response("success", "Notice added successfully", [
        "id"      => mysqli_insert_id($conn),
        "title"   => $title,
        "message" => $message
    ]);
} else {
    response("error", "Failed to add notice");
}

mysqli_close($conn);
