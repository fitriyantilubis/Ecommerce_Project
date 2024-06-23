<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$response = array();

if($_SERVER['REQUEST_METHOD'] == "GET") {
    if(isset($_GET['id']) && !empty($_GET['id'])) {
        $id = $_GET['id'];

        // Prepared statement untuk mencegah SQL injection
        $sql = "SELECT * FROM user WHERE id = ?";
        $stmt = $koneksi->prepare($sql);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();

        if($result->num_rows > 0) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil Menampilkan data user";
            $response['data'] = array();
            while ($row = $result->fetch_assoc()) {
                $response['data'][] = $row;
            }
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menampilkan data user";
            $response['data'] = null;
        }
        $stmt->close();
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "ID user tidak valid";
        $response['data'] = null;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode request tidak valid";
    $response['data'] = null;
}

echo json_encode($response);
?>
