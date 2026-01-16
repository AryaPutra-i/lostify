<?php
header("Content-Type: application/json");
include "database.php";

$user_id = $_GET['user_id'];
$query = $conn->prepare(
    "SELECT * FROM notifications WHERE user_id=? ORDER BY created_at DESC"
);
$query->bind_param("i", $user_id);
$query->execute();

echo json_encode(
    $query->get_result()->fetch_all(MYSQLI_ASSOC)
);
