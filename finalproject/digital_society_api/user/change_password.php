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

$user_id = $_POST['user_id'] ?? 0;
$old_password = $_POST['old_password'] ?? '';
$new_password = $_POST['new_password'] ?? '';

if(empty($user_id) || empty($old_password) || empty($new_password)){
    response("error","All fields required");
}

$stmt = $conn->prepare("SELECT password FROM users WHERE id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if(!$user || !password_verify($old_password, $user['password'])){
    response("error","Old password incorrect");
}

$hashed = password_hash($new_password, PASSWORD_DEFAULT);

$updateStmt = $conn->prepare("UPDATE users SET password = ? WHERE id = ?");
$updateStmt->bind_param("si", $hashed, $user_id);

if($updateStmt->execute()){
    response("success","Password changed successfully");
}else{
    response("error","Failed to change password");
}

$updateStmt->close();
$stmt->close();
$conn->close();
?>
