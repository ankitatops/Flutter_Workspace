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

$visitor_id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
$status = trim($_POST['status'] ?? 'approved');

if (!$visitor_id) {
    response("error", "Visitor ID required");
}

$stmt = mysqli_prepare($conn, "UPDATE visitors SET status=? WHERE id=?");
mysqli_stmt_bind_param($stmt, "si", $status, $visitor_id);

if (mysqli_stmt_execute($stmt)) {
    response("success", "Visitor status updated successfully", [
        "id"     => $visitor_id,
        "status" => $status
    ]);
} else {
    response("error", "Failed to update visitor status");
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
