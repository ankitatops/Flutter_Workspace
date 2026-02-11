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

$user_id = isset($_POST['user_id']) ? (int)$_POST['user_id'] : 0;

if (!$user_id) {
    response("error", "Maintenance ID required");
}

$stmt = mysqli_prepare($conn, "DELETE FROM maintenance WHERE user_id=?");
mysqli_stmt_bind_param($stmt, "i", $user_id);

if (mysqli_stmt_execute($stmt)) {
    if (mysqli_stmt_affected_rows($stmt) > 0) {
        response("success", "Maintenance record deleted successfully", ["user_id" => $user_id]);
    } else {
        response("error", "No maintenance record found with the given ID");
    }
} else {
    response("error", "Failed to delete maintenance record");
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
