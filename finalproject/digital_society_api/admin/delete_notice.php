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


$notice_id = isset($_POST['id']) ? (int)$_POST['id'] : 0;

if (!$notice_id) {
    response("error", "Notice ID required");
}

$stmt = mysqli_prepare($conn, "DELETE FROM notices WHERE id=?");
mysqli_stmt_bind_param($stmt, "i", $notice_id);

if (mysqli_stmt_execute($stmt)) {
    if (mysqli_stmt_affected_rows($stmt) > 0) {
        response("success", "Notice deleted successfully", ["id" => $notice_id]);
    } else {
        response("error", "No notice found with the given ID");
    }
} else {
    response("error", "Failed to delete notice");
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
