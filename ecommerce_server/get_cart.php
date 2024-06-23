<?php
include 'koneksi.php'; // Pastikan untuk menyertakan file koneksi

$id_user = $_GET['id_user']; // Ambil id_user dari parameter URL

$response = array();

if (isset($id_user)) {
    // Query untuk mengambil data keranjang dari tabel keranjang berdasarkan id_user
    $query = "
        SELECT 
            keranjang.id_keranjang, 
            keranjang.id_produk, 
            keranjang.jumlah, 
            keranjang.harga,
            produk.nama_produk,
            produk.gambar
        FROM keranjang 
        INNER JOIN produk ON keranjang.id_produk = produk.id_produk
        WHERE keranjang.id_user = '$id_user'
    ";
    $result = mysqli_query($koneksi, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        $cart_data = array();
        while ($row = mysqli_fetch_assoc($result)) {
            // Format data yang akan dikirim sebagai respons
            $cart_data[] = array(
                'id_keranjang' => $row['id_keranjang'],
                'id_produk' => $row['id_produk'],
                'jumlah' => $row['jumlah'],
                'harga' => $row['harga'],
                'nama_produk' => $row['nama_produk'],
                'gambar' => $row['gambar']
            );
        }
        $response['isSuccess'] = true;
        $response['message'] = "Data keranjang berhasil diambil";
        $response['data'] = $cart_data;
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Keranjang kosong atau tidak ditemukan";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Parameter id_user tidak diberikan";
}

echo json_encode($response);

mysqli_close($koneksi);
?>
