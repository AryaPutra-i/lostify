<?php
header("Content-Type: application/json");
include "database.php";

$id = $_POST['id'];
$query = $conn->prepare(
    "UPDATE reports SET status='Ditemukan' WHERE id=?"
);
$query->bind_param("i", $id);

echo json_encode(["success" => $query->execute()]);
