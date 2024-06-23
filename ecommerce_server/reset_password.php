<?php
require 'vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

include 'koneksi.php'; // Sesuaikan dengan file koneksi Anda

// Headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Memeriksa metode permintaan
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();

    // Memeriksa apakah email, otp, dan new_password sudah ada di body request
    if (isset($_POST['email']) && isset($_POST['otp']) && isset($_POST['new_password'])) {
        $email = $_POST['email'];
        $otp = $_POST['otp'];
        $newPassword = $_POST['new_password'];

        // Membersihkan input
        $email = mysqli_real_escape_string($koneksi, $email);
        $otp = mysqli_real_escape_string($koneksi, $otp);
        $newPassword = mysqli_real_escape_string($koneksi, $newPassword);

        // Memverifikasi OTP dan waktu kedaluwarsa
        $query = "SELECT * FROM user WHERE email='$email' AND code_verification='$otp'";
        $result = mysqli_query($koneksi, $query);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $otp_expiry = $row['otp_expiry'];

            // Memeriksa apakah OTP belum kedaluwarsa
            if (strtotime($otp_expiry) > time()) {
                // Enkripsi password baru dengan bcrypt
                $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

                // Update password di database
                $updateQuery = "UPDATE user SET password='$hashedPassword' WHERE email='$email'";
                if (mysqli_query($koneksi, $updateQuery)) {
                    $response['value'] = 1;
                    $response['message'] = 'Password berhasil direset';
                } else {
                    $response['value'] = 0;
                    $response['message'] = 'Gagal mereset password: ' . mysqli_error($koneksi);
                }
            } else {
                $response['value'] = 0;
                $response['message'] = 'OTP telah kedaluwarsa';
            }
        } else {
            $response['value'] = 0;
            $response['message'] = 'OTP tidak valid atau telah kedaluwarsa';
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
