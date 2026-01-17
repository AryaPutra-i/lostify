<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include "database.php";

// Check if request is POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["success" => false, "message" => "Method not allowed"]);
    exit();
}

// Get text data
$user_id = isset($_POST['user_id']) ? $_POST['user_id'] : '';
$title = isset($_POST['title']) ? $_POST['title'] : '';
$description = isset($_POST['description']) ? $_POST['description'] : '';
$category = isset($_POST['category']) ? $_POST['category'] : '';
$location = isset($_POST['location']) ? $_POST['location'] : '';
$status = isset($_POST['status']) ? $_POST['status'] : 'Hilang';

// Validation
if (empty($user_id) || empty($title) || empty($location)) {
    echo json_encode(["success" => false, "message" => "Please fill all required fields"]);
    exit();
}

$photoPath = null;

// Handle File Upload
if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
    $uploadDir = "uploads/";
    
    // Create directory if not exists
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }
    
    $fileExtension = pathinfo($_FILES['photo']['name'], PATHINFO_EXTENSION);
    $newFileName = uniqid() . "_" . time() . "." . $fileExtension;
    $targetFile = $uploadDir . $newFileName;
    
    if (move_uploaded_file($_FILES['photo']['tmp_name'], $targetFile)) {
        // Save relative path or full URL depending on your preference. 
        // Here we save the relative path: "uploads/filename.jpg"
        $photoPath = $targetFile;
    } else {
        echo json_encode(["success" => false, "message" => "Failed to upload photo"]);
        exit();
    }
}

// Insert into database
$sql = "INSERT INTO reports (user_id, title, description, category, location, photo, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);

if ($stmt) {
    $stmt->bind_param("issssss", $user_id, $title, $description, $category, $location, $photoPath, $status);
    
    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Report created successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => "Database error: " . $stmt->error]);
    }
    
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Statement error: " . $conn->error]);
}

$conn->close();
?>
