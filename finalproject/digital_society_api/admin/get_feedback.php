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
$query = "SELECT f.*, u.name AS user_name 
          FROM feedback f 
          JOIN users u ON f.user_id = u.id 
          ORDER BY f.id DESC";

$result = mysqli_query($conn, $query);

if (!$result) {
    response("error", "Failed to fetch feedbacks");
}

$feedbacks = [];
while ($row = mysqli_fetch_assoc($result)) {
    $feedbacks[] = $row;
}

response("success", "Feedbacks fetched successfully", $feedbacks);

mysqli_close($conn);
?>
