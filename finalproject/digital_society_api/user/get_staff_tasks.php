<?php
header('Content-Type: application/json');
require_once "../config/db.php";

function response($status, $message, $data = null){
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}

$staff_id = $_REQUEST['staff_id'] ?? '';

if(empty($staff_id)){
    response("error", "Staff ID required");
}

$checkStmt = $conn->prepare("SELECT id FROM staff WHERE id = ?");
$checkStmt->bind_param("i", $staff_id);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

if($checkResult->num_rows == 0){
    response("error", "Staff not found");
}
$stmt = $conn->prepare("SELECT * FROM staff_tasks WHERE staff_id = ? ORDER BY id DESC");
$stmt->bind_param("i", $staff_id);
$stmt->execute();
$result = $stmt->get_result();

$tasks = [];
while($row = $result->fetch_assoc()){
    $tasks[] = $row;
}

if(count($tasks) > 0){
    response("success", "Tasks fetched successfully", $tasks);
}else{
    response("success", "No tasks assigned", []);
}

$stmt->close();
$checkStmt->close();
$conn->close();
?>
