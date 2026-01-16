<?php
header("Content-Type: application/json");
include "database.php";

$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

// Validasi basic
if (empty($name) || empty($email) || empty($password)) {
    echo json_encode(["success" => false, "message" => "Data tidak lengkap"]);
    exit;
}

// Hash password removed per request
// $password = md5($password);

// Cek apakah email sudah ada
$checkQuery = $conn->prepare("SELECT id FROM users WHERE email = ?");
$checkQuery->bind_param("s", $email);
$checkQuery->execute();
$checkResult = $checkQuery->get_result();

if ($checkResult->num_rows > 0) {
    echo json_encode(["success" => false, "message" => "Email sudah terdaftar"]);
    exit;
}

// Insert user baru
$query = $conn->prepare("INSERT INTO users (name, email, password) VALUES (?, ?, ?)");
$query->bind_param("sss", $name, $email, $password);

if ($query->execute()) {
    echo json_encode(["success" => true, "message" => "Registrasi berhasil"]);
} else {
    echo json_encode(["success" => false, "message" => "Gagal menyimpan ke database: " . $conn->error]);
}
