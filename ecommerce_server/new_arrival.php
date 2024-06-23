<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'koneksi.php'; // Ensure this file correctly sets up a connection to your database.

// Query to select products ordered by the creation date descending
$sql = "SELECT * FROM produk ORDER BY created_at DESC LIMIT 10";  // Now limits to 10 newest products

$result = $koneksi->query($sql);

$newArrivals = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $newArrivals[] = array(
            'id_produk' => $row['id_produk'],
            'nama_produk' => $row['nama_produk'],
            'harga' => $row['harga'],
            'gambar' => $row['gambar'],
            'keterangan' => $row['keterangan'],
            'created_at' => $row['created_at']  // Optionally include the creation date
        );
    }
    echo json_encode(array("success" => true, "data" => $newArrivals));
} else {
    echo json_encode(array("success" => false, "message" => "No new arrivals found"));
}

$koneksi->close();
?>
