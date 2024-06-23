<?php
include 'koneksi.php';

$id_user = $_POST['id_user'];
$id_produk = $_POST['id_produk'];

// Check if already favorited
$sql_check = "SELECT * FROM favorit WHERE id_user = ? AND id_produk = ?";
$stmt_check = $koneksi->prepare($sql_check);
$stmt_check->bind_param("ii", $id_user, $id_produk);
$stmt_check->execute();
$result = $stmt_check->get_result();

if ($result->num_rows > 0) {
    // Already favorited, remove it
    $sql_delete = "DELETE FROM favorit WHERE id_user = ? AND id_produk = ?";
    $stmt_delete = $koneksi->prepare($sql_delete);
    $stmt_delete->bind_param("ii", $id_user, $id_produk);
    $stmt_delete->execute();
    echo json_encode(['isSuccess' => true, 'isFavorite' => false]);
} else {
    // Not favorited, add it
    $sql_insert = "INSERT INTO favorit (id_user, id_produk) VALUES (?, ?)";
    $stmt_insert = $koneksi->prepare($sql_insert);
    $stmt_insert->bind_param("ii", $id_user, $id_produk);
    $stmt_insert->execute();
    echo json_encode(['isSuccess' => true, 'isFavorite' => true]);
}
?>
