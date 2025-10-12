import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          _HelpSection(
            icon: Icons.search,
            title: 'Mencari dan Melihat Kamar',
            content:
                'Anda dapat melihat semua kamar yang tersedia langsung di halaman utama. Gunakan filter status (Kosong, Booked, Dihuni) untuk menyaring pencarian. Klik pada kartu kamar untuk melihat detail lengkap, termasuk fasilitas dan total harga sewa.',
          ),
          _HelpSection(
            icon: Icons.bookmark_add_outlined,
            title: 'Perbedaan Booking dan Sewa Langsung',
            content:
                '\"Booking\" adalah untuk mengamankan kamar dari tanggal yang Anda pilih. Anda harus menyelesaikan pembayaran dalam batas waktu yang ditentukan. \"Sewa Langsung\" akan langsung menjadikan Anda penghuni kamar tersebut setelah pembayaran berhasil dan tagihan pertama akan dibuat.',
          ),
          _HelpSection(
            icon: Icons.payment,
            title: 'Alur Pembayaran',
            content:
                '1.  **Bayar Tunai:** Pilih opsi ini jika Anda ingin membayar langsung ke admin. Permintaan Anda akan berstatus \"Menunggu Persetujuan\" hingga admin mengonfirmasi pembayaran Anda.\n'
                '2.  **Virtual Account (VA):** Pilih opsi ini untuk pembayaran transfer. Anda akan mendapatkan nomor VA unik dan timer 1 jam untuk menyelesaikan pembayaran. Setelah Anda menekan \"Saya Sudah Bayar\", sistem akan otomatis menyetujui permintaan Anda.\n'
                '3.  **QRIS:** Pilih opsi ini untuk menampilkan kode QR. Pindai kode tersebut dengan aplikasi perbankan Anda, lalu tekan \"Saya Sudah Bayar\" untuk konfirmasi otomatis.',
          ),
          _HelpSection(
            icon: Icons.report_problem_outlined,
            title: 'Melaporkan Kerusakan atau Masalah',
            content:
                'Jika Anda adalah penghuni, Anda dapat melaporkan kerusakan atau masalah melalui tombol \"Lapor Kerusakan\" di halaman utama. Isi formulir dengan detail masalah, dan laporan Anda akan diteruskan ke admin.',
          ),
          _HelpSection(
            icon: Icons.qr_code_scanner,
            title: 'Mencatat Kehadiran (Scan QR)',
            content:
                'Sebagai penghuni, Anda dapat mencatat kapan Anda \"Berangkat\" dari kost atau \"Pulang\" ke kost dengan menekan tombol \"Scan Kehadiran\". Arahkan kamera ke kode QR yang tersedia di area kost untuk mencatat aktivitas Anda. Fitur ini membantu admin memantau keamanan dan kehadiran.',
          ),
        ].animate(interval: 100.ms).fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
      ),
    );
  }
}

class _HelpSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _HelpSection({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content, style: const TextStyle(height: 1.5)),
          ),
        ],
      ),
    );
  }
}
