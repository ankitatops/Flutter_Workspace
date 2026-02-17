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

if(!isset($_POST['id']) || !isset($_POST['user_id'])){
    response("error", "id and user_id are required", []);
}

$problem_id = intval($_POST['id']);
$user_id = intval($_POST['user_id']);

$q = "DELETE FROM problems WHERE id = '$problem_id' AND user_id = '$user_id'";
$r = mysqli_query($conn, $q);

if(!$r){
    response("error", "Query failed: " . mysqli_error($conn), []);
}

if(mysqli_affected_rows($conn) == 0){
    response("error", "Problem not found or unauthorized", []);
}

response("success", "Problem deleted successfully", []);

$conn->close();
?>
