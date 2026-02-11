<?php
header('Content-Type: application/json');

include "../config/db.php";

// Response function
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

if (!$event_id) {
    response("error", "Event ID required");
}

$stmt = mysqli_prepare($conn, "DELETE FROM events WHERE id=?");
mysqli_stmt_bind_param($stmt, "i", $event_id);

if (mysqli_stmt_execute($stmt)) {
    if (mysqli_stmt_affected_rows($stmt) > 0) {
        response("success", "Event deleted successfully", ["id" => $event_id]);
    } else {
        response("error", "No event found with the given ID");
    }
} else {
    response("error", "Failed to delete event");
}
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
