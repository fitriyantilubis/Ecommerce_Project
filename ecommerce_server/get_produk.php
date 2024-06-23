<?php
include 'koneksi.php'; // Make sure to include your database connection file

$id_produk = $_GET['id_produk']; // Get the product ID from the request parameters

$response = array();

if (isset($id_produk)) {
    // Query to fetch product details based on the provided ID
    $query = "SELECT * FROM produk WHERE id_produk = '$id_produk'";
    $result = mysqli_query($koneksi, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        $product_data = mysqli_fetch_assoc($result);
        $response['isSuccess'] = true;
        $response['message'] = "Product details retrieved successfully";
        $response['data'] = $product_data;
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Product not found";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Product ID parameter not provided";
}

// Return the response as JSON
echo json_encode($response);

mysqli_close($koneksi);
?>
