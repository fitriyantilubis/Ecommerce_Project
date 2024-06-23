<?php
include 'koneksi.php';

// Check if user_id is provided
if (!isset($_GET['user_id'])) {
    echo json_encode(['error' => 'User ID is required']);
    exit;
}

$user_id = $_GET['user_id'];

// Prepare SQL query to fetch favorite products for a user
$sql = "SELECT p.* FROM produk p INNER JOIN favorit f ON p.id_produk = f.id_produk WHERE f.id_user = ?";
$stmt = $koneksi->prepare($sql);

if (!$stmt) {
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit;
}

$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$products = [];
while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}

echo json_encode(['data' => $products]);
?>
