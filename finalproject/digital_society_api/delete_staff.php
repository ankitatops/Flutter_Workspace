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


$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;


if (!$id) {
    response("error", "Staff ID required");
}

$task_stmt = mysqli_prepare($conn, "DELETE FROM staff_tasks WHERE staff_id=?");
mysqli_stmt_bind_param($task_stmt, "i", $id);
mysqli_stmt_execute($task_stmt);
mysqli_stmt_close($task_stmt);


$staff_stmt = mysqli_prepare($conn, "DELETE FROM staff WHERE id=?");
mysqli_stmt_bind_param($staff_stmt, "i", $id);

if (mysqli_stmt_execute($staff_stmt)) {
    if (mysqli_stmt_affected_rows($staff_stmt) > 0) {
        response("success", "Staff deleted successfully", ["id" => $id]);
    } else {
        response("error", "No staff found with the given ID");
    }
} else {
    response("error", "Failed to delete staff");
}


mysqli_stmt_close($staff_stmt);
mysqli_close($conn);
?>
