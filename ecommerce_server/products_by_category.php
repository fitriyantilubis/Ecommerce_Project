<?php
include 'koneksi.php';
header("Content-Type: application/json");

// Default response format
$response = [
    'success' => false,
    'data' => [],
    'message' => 'No data found.'
];

$id_kategori = isset($_GET['id_kategori']) ? intval($_GET['id_kategori']) : 0;

if ($id_kategori > 0) {
    $sql = "SELECT * FROM produk WHERE id_kategori = ?";
    $stmt = $koneksi->prepare($sql);
    
    if ($stmt) {
        $stmt->bind_param("i", $id_kategori);
        $stmt->execute();
        $result = $stmt->get_result();

        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }

        if (count($products) > 0) {
            $response['success'] = true;
            $response['data'] = $products;
            $response['message'] = 'Data retrieved successfully.';
        } else {
            $response['message'] = 'No products found for the given category.';
        }
    } else {
        $response['message'] = 'Failed to prepare the SQL statement.';
    }
} else {
    $response['message'] = 'Invalid or missing category ID.';
}

echo json_encode($response);
?>
