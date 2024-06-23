<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

function kirimResponse($sukses, $status, $pesan, $data = null) {
    $response = [
        'sukses' => $sukses,
        'status' => $status,
        'pesan' => $pesan
    ];

    if ($data !== null) {
        $response['data'] = $data;
    }

    header('Content-Type: application/json');
    echo json_encode($response);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login'])) {
    include 'koneksi.php';
    $username = $_POST['username'];
    $password = $_POST['password'];

    $result = loginUser($koneksi, $username, $password);
    echo $result;
}
function loginUser($koneksi, $username, $password) {
    $query = "SELECT * FROM user WHERE username='$username'";
    $result = mysqli_query($koneksi, $query);

    if (mysqli_num_rows($result) == 1) {
        $row = mysqli_fetch_assoc($result);
        if (password_verify($password, $row['password'])) {
            $response = [
                'sukses' => true,
                'status' => 200,
                'pesan' => 'Login berhasil',
                'data' => $row
            ];
        } else {
            $response = [
                'sukses' => false,
                'status' => 401,
                'pesan' => 'Login gagal, username atau password salah',
                'data'=> null
            ];
        }
    } else {
        $response = [
            'sukses' => false,
            'status' => 401,
            'pesan' => 'Login gagal, username atau password salah',
            'data'=> null
        ];
    }

    return json_encode($response);
}
?>
