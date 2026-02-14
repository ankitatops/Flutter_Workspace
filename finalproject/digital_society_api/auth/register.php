<?php
header('Content-Type: application/json');
include "../config/db.php";

function response($status, $message, $data = [])
{
    echo json_encode([
        "status"  => $status,
        "message" => $message,
        "data"    => $data
    ]);
    exit;
}

$name     = $_POST['name'] ?? '';
$email    = $_POST['email'] ?? '';
$phone    = $_POST['phone'] ?? '';
$flat     = $_POST['flat_no'] ?? '';
$password = $_POST['password'] ?? '';
$role = $_POST['role'] ?? '';


if (!$name || !$email || !$phone || !$flat || !$password) {
    response("error", "All fields are required");
}

$check = mysqli_query($conn, "SELECT id FROM users WHERE email='$email'");
if (mysqli_num_rows($check) > 0) {
    response("error", "Email already registered");
}

$hashed_password = password_hash($password, PASSWORD_DEFAULT);

$q = "INSERT INTO users (name,email,phone,flat_no,password,role)
      VALUES ('$name','$email','$phone','$flat','$hashed_password','$role')";

if (mysqli_query($conn, $q)) {
    response("success", "User registered successfully");
} else {
    response("error", "Registration failed");
}
