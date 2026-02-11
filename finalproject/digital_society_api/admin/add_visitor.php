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

$name = trim($_POST['name'] ?? "");
$flat_no = trim($_POST['flat_no'] ?? "");
$visit_date = trim($_POST['visit_date'] ?? "");

if (!$name || !$flat_no || !$visit_date) {
    response("error", "All fields required");
}

$q = "INSERT INTO visitors (name, flat_no, visit_date, status) VALUES ('$name', '$flat_no', '$visit_date', 'pending')";

if (mysqli_query($conn, $q)) {
    response("success", "Visitor added successfully", [
        "id"         => mysqli_insert_id($conn),
        "name"       => $name,
        "flat_no"    => $flat_no,
        "visit_date" => $visit_date,
        "status"     => "pending"
    ]);
} else {
    response("error", "Failed to add visitor");
}

mysqli_close($conn);
?>
