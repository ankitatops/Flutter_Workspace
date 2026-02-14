<?php
header('Content-Type: application/json');
session_start();

function response($status, $message){
    echo json_encode([
        "status" => $status,
        "message" => $message
    ]);
    exit;
}

session_unset();
session_destroy();

response("success", "Logout successful");
?>
