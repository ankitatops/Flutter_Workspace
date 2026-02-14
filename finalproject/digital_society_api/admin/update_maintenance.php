<?php
header('Content-Type: application/json');
include "../config/db.php";

function response($status, $message, $data = []) {
    echo json_encode([
        "status" => $status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}

$id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
$amount = isset($_POST['amount']) ? (float)trim($_POST['amount']) : 0;
$status = isset($_POST['status']) ? trim($_POST['status']) : '';

if ($id <= 0 || $amount === 0 || $status === '') {
    response("error", "All fields are required");
}

$allowed_status = ["pending", "completed"];
if (!in_array($status, $allowed_status)) {
    response("error", "Invalid status value. Allowed: pending, completed");
}

$check = $conn->prepare("SELECT id FROM maintenance WHERE id = ?");
$check->bind_param("i", $id);
$check->execute();
$check->store_result();

if ($check->num_rows == 0) {
    response("error", "Invalid ID. Record not found");
}
$check->close();

$stmt = $conn->prepare("UPDATE maintenance SET amount = ?, status = ? WHERE id = ?");
$stmt->bind_param("dsi", $amount, $status, $id);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        $display_status = ($status === "completed") ? "completesd" : $status;

        response("success", "Maintenance updated successfully", [
            "id" => $id,
            "amount" => $amount,
            "status" => $display_status
        ]);
    } else {
        response("info", "No changes made (same data)");
    }
} else {
    response("error", "Update failed");
}

$stmt->close();
$conn->close();
?>
