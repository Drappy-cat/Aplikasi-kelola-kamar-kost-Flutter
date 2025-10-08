import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF72585), Color(0xFF5B2EBC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'Syarat dan Ketentuan Penggunaan Aplikasi Ri-Kost',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // String yang diperbaiki di bawah ini
          Text(
            'Selamat datang di Ri-Kost. Dengan mengunduh, menginstal, dan/atau menggunakan aplikasi Ri-Kost ("Aplikasi"), Anda setuju bahwa Anda telah membaca, memahami, dan menerima serta menyetujui Syarat dan Ketentuan Penggunaan ini ("Ketentuan Penggunaan").',
          ),
          SizedBox(height: 16),
          Text(
            '1. Definisi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '   a. "Kami" berarti pengembang dan pemilik Aplikasi Ri-Kost.\n'
            '   b. "Anda" atau "Pengguna" berarti setiap orang yang menggunakan Aplikasi.\n'
            '   c. "Layanan" berarti semua fitur, layanan, dan konten yang disediakan melalui Aplikasi.',
          ),
          SizedBox(height: 16),
          Text(
            '2. Penggunaan Layanan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '   a. Anda setuju untuk menggunakan Aplikasi hanya untuk tujuan yang sah dan sesuai dengan semua hukum dan peraturan yang berlaku.\n'
            '   b. Anda bertanggung jawab penuh atas semua aktivitas yang terjadi di bawah akun Anda.',
          ),
          SizedBox(height: 16),
          Text(
            '3. Pembayaran',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '   a. Semua pembayaran sewa harus dilakukan sesuai dengan jadwal yang telah ditentukan.\n'
            '   b. Keterlambatan pembayaran dapat dikenakan denda sesuai dengan kebijakan yang berlaku.',
          ),
          SizedBox(height: 16),
          Text(
            '4. Pembatasan Tanggung Jawab',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '   Kami tidak bertanggung jawab atas kehilangan atau kerusakan barang pribadi milik Pengguna di dalam area kost. Pengguna disarankan untuk selalu menjaga keamanan barang-barang pribadi mereka.',
          ),
          SizedBox(height: 24),
          Text(
            'Ketentuan ini terakhir diperbarui pada: 28 Juli 2024.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
