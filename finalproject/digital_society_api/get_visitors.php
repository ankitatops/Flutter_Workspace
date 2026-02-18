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


if(!isset($_POST['id']) || empty($_POST['id'])){
    response("error", "User ID is required");
}

$user_id = intval($_POST['id']);

$stmtUser = $conn->prepare("SELECT flat_no FROM users WHERE id = ?");
$stmtUser->bind_param("i", $user_id);
$stmtUser->execute();
$resultUser = $stmtUser->get_result();

if($resultUser->num_rows == 0){
    response("error", "User not found");
}

$userData = $resultUser->fetch_assoc();
$flat_no = $userData['flat_no'];
$stmtUser->close();

$stmt = $conn->prepare("SELECT * FROM visitors WHERE flat_no = ? ORDER BY visit_date DESC");
$stmt->bind_param("i", $flat_no);
$stmt->execute();
$result = $stmt->get_result();

$visitors = [];

while($row = $result->fetch_assoc()){
    $visitors[] = $row;
}

$stmt->close();
$conn->close();

if(count($visitors) > 0){
    response("success", "Visitors fetched successfully", $visitors);
}else{
    response("success", "No visitors found for this flat", []);
}
?>
