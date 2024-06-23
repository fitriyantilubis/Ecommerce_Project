<?php
header('Content-Type: application/json');

// Koneksi ke database
include 'koneksi.php'; // Pastikan untuk menyertakan file koneksi

// Ambil data dari POST request
$data = json_decode(file_get_contents("php://input"), true);
$id_user = $data['id_user'];
$total_amount = $data['total_amount'];
$address = $data['address'];
$payment_method = $data['payment_method']; // Tidak digunakan dalam query, tapi bisa disimpan jika dibutuhkan
$items = $data['items'];

// Insert ke tabel orders
$order_date = date('Y-m-d H:i:s');
$status = "Pending";

$sql_order = "INSERT INTO orders (id_user, order_date, total_amount, status, alamat) VALUES ('$id_user', '$order_date', '$total_amount', '$status', '$address')";
if ($koneksi->query($sql_order) === TRUE) {
    $id_order = $koneksi->insert_id;

    // Insert ke tabel order_detail
    foreach ($items as $item) {
        $id_produk = $item['id_produk'];
        $quantity = $item['quantity'];
        $price_per_unit = $item['price_per_unit'];
        $subtotal = $item['subtotal'];

        // Gunakan $id_order yang baru saja dibuat
        $sql_order_detail = "INSERT INTO order_details (id_order, id_produk, quantity, price_per_unit, subtotal) VALUES ('$id_order', '$id_produk', '$quantity', '$price_per_unit', '$subtotal')";
        if (!$koneksi->query($sql_order_detail)) {
            echo json_encode(["status" => "error", "message" => "Error: " . $sql_order_detail . "<br>" . $koneksi->error]);
            $koneksi->close();
            exit();
        }
    }

    echo json_encode(["status" => "success", "message" => "Order placed successfully", "id_order" => $id_order]);
} else {
    echo json_encode(["status" => "error", "message" => "Error: " . $sql_order . "<br>" . $koneksi->error]);
}

?>
