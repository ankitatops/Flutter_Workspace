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

if(empty($user_id)){
    response("error","User ID is required");
}

$stmt = $conn->prepare("SELECT * FROM maintenance WHERE user_id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
while($row = $result->fetch_assoc()){
    $data[] = $row;
}

if(count($data) > 0){
    response("success","Maintenance list",$data);
}else{
    response("success","No maintenance records found",[]);
}

$stmt->close();
$conn->close();
?>
