<?php
header("Content-Type: application/json");

$targetDir = "uploads/";
$fileName = time() . "_" . basename($_FILES["photo"]["name"]);
$targetFile = $targetDir . $fileName;

if (move_uploaded_file($_FILES["photo"]["tmp_name"], $targetFile)) {
    echo json_encode(["success" => true, "file" => $fileName]);
} else {
    echo json_encode(["success" => false]);
}
