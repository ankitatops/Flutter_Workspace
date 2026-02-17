<?php
header("Content-Type: application/json");
include("config/db.php");

$id     = $_POST['id'] ?? '';
$amount = $_POST['amount'] ?? '';
$status = $_POST['status'] ?? '';

if ($id == '' || $amount == '' || $status == '') {
    echo json_encode([
        "status" => "error",
        "message" => "All fields are required"
    ]);
    exit;
}

$sql = "UPDATE maintenance 
        SET amount='$amount', status='$status' 
        WHERE id='$id'";

if (mysqli_query($conn, $sql)) {
    if (mysqli_affected_rows($conn) > 0) {
        echo json_encode([
            "status" => "success",
            "message" => "Maintenance updated successfully"
        ]);
    } else {
        echo json_encode([
            "status" => "info",
            "message" => "No changes made"
        ]);
    }
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Update failed"
    ]);
}

mysqli_close($conn);
?>
