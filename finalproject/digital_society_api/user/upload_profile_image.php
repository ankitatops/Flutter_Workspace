<?php
header('Content-Type: application/json');
include "../config/db.php";

function response($status, $message, $data = []){
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}

$user_id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
if(!$user_id) response("error", "User ID required");

if(!isset($_FILES['image']) || $_FILES['image']['error'] != 0){
    response("error", "Image file required");
}

$targetDir = "../uploads/users/";
if(!is_dir($targetDir)) mkdir($targetDir, 0777, true);

$imageName = time() . "_" . basename($_FILES['image']['name']);
$targetFile = $targetDir . $imageName;

if(move_uploaded_file($_FILES['image']['tmp_name'], $targetFile)){
    $q = "UPDATE users SET image='$imageName' WHERE id=$user_id";
    if(mysqli_query($conn, $q)){
        response("success", "Profile image updated", ["image_url"=>"../uploads/users/$imageName"]);
    } else {
        response("error", "DB update failed");
    }
} else {
    response("error", "Failed to upload image");
}

mysqli_close($conn);
?>
