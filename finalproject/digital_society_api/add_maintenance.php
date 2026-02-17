<?php
header('Content-Type: application/json');
include "config/db.php";

function response($status, $message, $data = [])
{
    echo json_encode([
        "status"  => $status,
        "message" => $message,
        "data"    => $data
    ]);
    exit;
}

$user_id = $_POST['user_id'] ?? '';
$amount  = $_POST['amount'] ?? '';
$due     = $_POST['due_date'] ?? '';

if (!$user_id || !$amount || !$due) {
    response("error", "User ID, amount and due date required");
}

if (!preg_match("/^\d{4}-\d{2}-\d{2}$/", $due)) {
    response("error", "Invalid due date format (YYYY-MM-DD)");
}

$q = "INSERT INTO maintenance (user_id, amount, status, due_date)
      VALUES ('$user_id', '$amount', 'pending', '$due')";

if (mysqli_query($conn, $q)) {
    response("success", "Maintenance added successfully");
} else {
    response("error", "Failed to add maintenance");
}
