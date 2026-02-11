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
$title = trim($_POST['title'] ?? '');
$message = trim($_POST['message'] ?? '');

if (!$notice_id || !$title || !$message) {
    response("error", "All fields required");
}

$stmt = mysqli_prepare($conn, "UPDATE notices SET title=?, message=? WHERE id=?");
mysqli_stmt_bind_param($stmt, "ssi", $title, $message, $notice_id);

if (mysqli_stmt_execute($stmt)) {
    if (mysqli_stmt_affected_rows($stmt) > 0) {
        response("success", "Notice updated successfully", [
            "id"          => $notice_id,
            "title"       => $title,
            "description" => $description
        ]);
    } else {
        response("error", "No notice found or no changes made");
    }
} else {
    response("error", "Failed to update notice");
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
