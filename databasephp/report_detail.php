<?php
header("Content-Type: application/json");
include "database.php";

$id = $_GET['id'];
$query = $conn->prepare("SELECT * FROM reports WHERE id=?");
$query->bind_param("i", $id);
$query->execute();

echo json_encode($query->get_result()->fetch_assoc());
