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

$name = trim($_POST['name'] ?? "");
$role = trim($_POST['role'] ?? "");

if (!$name || !$role) {
    response("error", "Name and role required");
}

$q = "INSERT INTO staff (name, role) VALUES ('$name', '$role')";

if (mysqli_query($conn, $q)) {
    response("success", "Staff added successfully", [
        "id"   => mysqli_insert_id($conn),
        "name" => $name,
        "role" => $role
    ]);
} else {
    response("error", "Failed to add staff");
}

mysqli_close($conn);
