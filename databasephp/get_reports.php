<?php
header("Content-Type: application/json");
include "database.php";

$sql = "SELECT r.*, u.name 
        FROM reports r 
        JOIN users u ON r.user_id=u.id
        ORDER BY r.created_at DESC";

$result = $conn->query($sql);
echo json_encode($result->fetch_all(MYSQLI_ASSOC));
