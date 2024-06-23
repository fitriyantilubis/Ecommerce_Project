<?php


include 'koneksi.php';

// Headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Memeriksa metode permintaan
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();

    // Memeriksa apakah semua parameter sudah diatur
    if (isset($_POST['username']) && isset($_POST['password']) && isset($_POST['fullname']) && isset($_POST['email']) && isset($_POST['nohp'])) {
        $username = $_POST['username'];
        $password = password_hash($_POST['password'], PASSWORD_BCRYPT); // Hashing password
        $fullname = $_POST['fullname'];
        $email = $_POST['email'];
        $nohp = $_POST['nohp'];

        // Membersihkan input
        $username = mysqli_real_escape_string($koneksi, $username);
        $fullname = mysqli_real_escape_string($koneksi, $fullname);
        $email = mysqli_real_escape_string($koneksi, $email);
        $nohp = mysqli_real_escape_string($koneksi, $nohp);

        // Memeriksa apakah email sudah ada
        $checkEmailQuery = "SELECT * FROM user WHERE email='$email'";
        $emailResult = mysqli_query($koneksi, $checkEmailQuery);

        if (mysqli_num_rows($emailResult) > 0) {
            $response['value'] = 2;
            $response['message'] = 'Email sudah digunakan';
        } else {
            // Menyimpan pengguna baru
            $insertQuery = "INSERT INTO user (username, password, fullname, email, nohp, created_at, updated_at) VALUES ('$username', '$password', '$fullname', '$email', '$nohp', NOW(), NOW())";
            if (mysqli_query($koneksi, $insertQuery)) {
                $response['value'] = 1;
                $response['message'] = 'Pendaftaran berhasil. Silakan verifikasi email Anda.';
            } else {
                $response['value'] = 0;
                $response['message'] = 'Gagal menyimpan pengguna baru: ' . mysqli_error($koneksi);
            }
        }
    } else {
        $response['value'] = 0;
        $response['message'] = 'Parameter yang diperlukan tidak ada';
    }

    echo json_encode($response);
} else {
    $response['value'] = 0;
    $response['message'] = 'Metode permintaan tidak valid';
    echo json_encode($response);
}

mysqli_close($koneksi);

?>
