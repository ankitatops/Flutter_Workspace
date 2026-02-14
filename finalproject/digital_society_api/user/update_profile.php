<?php
header('Content-Type: application/json');
include "../config/db.php";

function response($status, $message, $data = null){
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}

$id = $_POST['id'] ?? 0;
$name = trim($_POST['name'] ?? '');
$phone = trim($_POST['phone'] ?? '');
$flat_no = trim($_POST['flat_no'] ?? '');

if(!$id){
    response("error","User ID required");
}

$stmt = $conn->prepare("UPDATE users SET name = ?, phone = ?, flat_no = ? WHERE id = ?");
$stmt->bind_param("sssi", $name, $phone, $flat_no, $id);

if($stmt->execute()){
    response("success","Profile updated successfully");
}else{
    response("error","Failed to update profile");
}

$stmt->close();
$conn->close();
?>
