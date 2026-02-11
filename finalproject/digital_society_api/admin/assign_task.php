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

$staff_id = isset($_POST['staff_id']) ? (int)$_POST['staff_id'] : 0;
$task = trim($_POST['task'] ?? "");

if (!$staff_id || !$task) {
    response("error", "Staff ID and task required");
}
$stmt = mysqli_prepare($conn, "INSERT INTO staff_tasks (staff_id, task, status) VALUES (?, ?, 'pending')");
mysqli_stmt_bind_param($stmt, "is", $staff_id, $task);

if (mysqli_stmt_execute($stmt)) {
    response("success", "Task assigned successfully", [
        "task_id"  => mysqli_insert_id($conn),
        "staff_id" => $staff_id,
        "task"     => $task,
        "status"   => "pending"
    ]);
} else {
    response("error", "Failed to assign task");
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
