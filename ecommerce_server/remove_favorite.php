<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'koneksi.php'; // Ensure this file correctly sets up a connection to your database.

$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = isset($_POST['user_id']) ? $_POST['user_id'] : null;
    $product_id = isset($_POST['product_id']) ? $_POST['product_id'] : null;

    if (!empty($user_id) && !empty($product_id)) {
        // Prepare the SQL statement to delete the favorite
        $stmt = $koneksi->prepare("DELETE FROM favorit WHERE id_user = ? AND id_produk = ?");
        $stmt->bind_param("ii", $user_id, $product_id); // Assume both IDs are integers

        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                $response['isSuccess'] = true;
                $response['message'] = "Product successfully removed from favorites.";
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "No favorite found to remove.";
            }
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Failed to remove the product from favorites.";
        }
        $stmt->close();
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Invalid input - User ID and Product ID are required.";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Invalid request method - POST required.";
}

echo json_encode($response);
?>
