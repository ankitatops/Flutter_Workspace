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

$email    = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (!$email || !$password) {
    response("error", "Email and password required");
}

$q = "SELECT * FROM users WHERE email='$email'";
$r = mysqli_query($conn, $q);

if (mysqli_num_rows($r) > 0) {
    $user = mysqli_fetch_assoc($r);

    if (password_verify($password, $user['password'])) {
        unset($user['password']); 
        response("success", "Login successful", $user);
    } else {
        response("error", "Invalid password");
    }
} else {
    response("error", "User not found");
}
