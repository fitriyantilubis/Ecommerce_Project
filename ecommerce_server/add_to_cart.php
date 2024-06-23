<?php
include 'koneksi.php'; // Pastikan untuk menyertakan file koneksi

$id_user = $_POST['id_user'];
$id_produk = $_POST['id_produk'];
$jumlah = $_POST['jumlah'];

$response = array();

if (isset($id_user) && isset($id_produk) && isset($jumlah)) {
    // Ambil harga dari tabel produk berdasarkan id_produk
    $query = "SELECT harga FROM produk WHERE id_produk = '$id_produk'";
    $result = mysqli_query($koneksi, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $harga = $row['harga'];

        $insert_query = "INSERT INTO keranjang (id_user, id_produk, jumlah, harga) VALUES ('$id_user', '$id_produk', '$jumlah', '$harga')
                         ON DUPLICATE KEY UPDATE jumlah = jumlah + '$jumlah'";

        if (mysqli_query($koneksi, $insert_query)) {
            $response['isSuccess'] = true;
            $response['message'] = "Produk berhasil ditambahkan ke keranjang";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan produk ke keranjang";
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Produk tidak ditemukan";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Data tidak lengkap";
}

echo json_encode($response);

mysqli_close($koneksi);
?>
