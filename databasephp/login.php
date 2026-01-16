<?php
header("Content-Type: application/json");
include "database.php";

$email = $_POST['email'];
$password = $_POST['password'];

$query = $conn->prepare(
    "SELECT id, name, email FROM users WHERE email=? AND password=?"
);
$query->bind_param("ss", $email, $password);
$query->execute();
$result = $query->get_result();

if ($result->num_rows > 0) {
    echo json_encode([
        "success" => true,
        "user" => $result->fetch_assoc()
    ]);
} else {
    echo json_encode(["success" => false]);
}
