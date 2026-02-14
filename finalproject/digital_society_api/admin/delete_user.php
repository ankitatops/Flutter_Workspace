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

$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
if (!$id) {
    response("error", "User ID required");
}

$stmt = mysqli_prepare($conn, "DELETE FROM users WHERE id=?");
mysqli_stmt_bind_param($stmt, "i", $id);

if (mysqli_stmt_execute($stmt)) {
    if (mysqli_stmt_affected_rows($stmt) > 0) {
        response("success", "User deleted successfully", ["id" => $id]);
    } else {
        response("error", "No user found with the given ID");
    }
} else {
    response("error", "Failed to delete user");
}
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
