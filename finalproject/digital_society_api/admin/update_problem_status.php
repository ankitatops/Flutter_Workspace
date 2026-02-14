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
$status = trim($_POST['status'] ?? 'closed');

if (!$id) {
    response("error", "Problem ID required");
}

$stmt = mysqli_prepare($conn, "UPDATE problems SET status=? WHERE id=?");
mysqli_stmt_bind_param($stmt, "si", $status, $id);

if (mysqli_stmt_execute($stmt)) {
    if (mysqli_stmt_affected_rows($stmt) > 0) {
        response("success", "Problem updated successfully", [
            "id"     => $id,
            "status" => $status
        ]);
    } else {
        response("error", "No problem found or no changes made");
    }
} else {
    response("error", "Failed to update problem");
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
