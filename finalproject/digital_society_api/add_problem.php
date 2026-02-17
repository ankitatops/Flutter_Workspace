<?php
header('Content-Type: application/json');

include "config/db.php";

function response($status, $message, $data = null){
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}
$user_id = $_POST['user_id'] ?? '';
$problem = $_POST['problem'] ?? '';

if(empty($user_id) || empty($problem)){
    response("error", "User ID and Problem are required");
}

$stmt = $conn->prepare("INSERT INTO problems (user_id, problem, status) VALUES (?, ?, 'open')");
$stmt->bind_param("is", $user_id, $problem);

if($stmt->execute()){
    response("success", "Problem submitted successfully");
}else{
    response("error", "Failed to submit problem");
}

$stmt->close();
$conn->close();
?>
