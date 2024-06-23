<?php
header('Content-Type: application/json');

// Koneksi ke database
include 'koneksi.php'; // Pastikan untuk menyertakan file koneksi

// Ambil id_user dari parameter POST
$id_user = $_POST['id_user'];

$response = array();

if (isset($id_user)) {
    // Query untuk mengambil data pesanan berdasarkan id_user
    $query = "
        SELECT 
            orders.id_order,
            orders.id_user,
            orders.order_date,
            orders.total_amount,
            orders.status,
            orders.alamat,
            order_details.id_detail,
            order_details.id_produk,
            order_details.quantity,
            order_details.price_per_unit,
            order_details.subtotal,
            produk.nama_produk
        FROM orders 
        INNER JOIN order_details ON orders.id_order = order_details.id_order
        INNER JOIN produk ON order_details.id_produk = produk.id_produk
        WHERE orders.id_user = ?
    ";
    
    if ($stmt = mysqli_prepare($koneksi, $query)) {
        mysqli_stmt_bind_param($stmt, 's', $id_user);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if ($result && mysqli_num_rows($result) > 0) {
            $orders = array();
            while ($row = mysqli_fetch_assoc($result)) {
                $orders[] = $row;
            }
            $response['isSuccess'] = true;
            $response['message'] = "Data pesanan berhasil diambil";
            $response['data'] = $orders;
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Data pesanan tidak ditemukan";
        }

        mysqli_stmt_close($stmt);
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Query tidak dapat diproses";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Parameter id_user tidak diberikan";
}

echo json_encode($response);

mysqli_close($koneksi);
?>
