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

$user_id = $_POST['user_id'] ?? 0;
$message = trim($_POST['message'] ?? '');

if(!$user_id || !$message){
    response("error", "User ID and message required");
}

$stmt = $conn->prepare("INSERT INTO feedback (user_id, message, date) VALUES (?, ?, NOW())");
$stmt->bind_param("is", $user_id, $message);

if($stmt->execute()){
    response("success", "Feedback sent successfully");
}else{
    response("error", "Failed to send feedback");
}

$stmt->close();
$conn->close();
?>
