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
$event_id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
$title = trim($_POST['title'] ?? '');
$description = trim($_POST['description'] ?? '');
$event_date = trim($_POST['event_date'] ?? '');

if (!$event_id || !$title || !$description || !$event_date) {
    response("error", "All fields required");
}

$stmt = mysqli_prepare($conn, "UPDATE events SET title=?, description=?, event_date=? WHERE id=?");
mysqli_stmt_bind_param($stmt, "sssi", $title, $description, $event_date, $event_id);

if (mysqli_stmt_execute($stmt)) {
    if (mysqli_stmt_affected_rows($stmt) > 0) {
        response("success", "Event updated successfully", [
            "id"          => $event_id,
            "title"        => $title,
            "description" => $description,
            "date"        => $date
        ]);
    } else {
        response("error", "No event found or no changes made");
    }
} else {
    response("error", "Failed to update event");
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
