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

$email    = isset($_POST['email']) ? trim($_POST['email']) : '';
$password = isset($_POST['password']) ? trim($_POST['password']) : '';

if (empty($email) || empty($password)) {
    response("error", "Email and password required");
}

$q = "SELECT * FROM users WHERE email = '$email'";
$r = mysqli_query($conn, $q);

if (mysqli_num_rows($r) > 0) {

    $user = mysqli_fetch_assoc($r);

    if (password_verify($password, $user['password'])) {

        $role = $user['role'];

        unset($user['password']);

        response("success", "Login successful", [
            "id"      => $user['id'],
            "name"    => $user['name'],
            "email"   => $user['email'],
            "phone"   => $user['phone'],
            "flat_no" => $user['flat_no'],
            "role"    => $role
        ]);

    } else {
        response("error", "Invalid password");
    }

} else {
    response("error", "User not found");
}

mysqli_close($conn);
?>
