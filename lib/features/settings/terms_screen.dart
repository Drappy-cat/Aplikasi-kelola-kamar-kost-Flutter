import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan'),
        // PERBAIKAN: Menggunakan warna primer dari tema untuk konsistensi
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Syarat dan Ketentuan Penggunaan Aplikasi Ri-Kost',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Dengan mengunduh, menginstal, dan/atau menggunakan aplikasi Ri-Kost ("Aplikasi"), Anda setuju bahwa Anda telah membaca, memahami, dan menerima serta menyetujui Syarat dan Ketentuan Penggunaan ini ("Ketentuan Penggunaan").',
            style: TextStyle(color: Colors.grey),
          ),
          const Divider(height: 32),

          _buildTermSection(
            context,
            icon: Icons.person_outline,
            title: '1. Pendaftaran dan Akun Pengguna',
            points: [
              'Anda harus memberikan informasi yang akurat, terkini, dan lengkap selama proses pendaftaran.',
              'Anda bertanggung jawab penuh untuk menjaga kerahasiaan kata sandi Anda dan semua aktivitas yang terjadi di bawah akun Anda.',
              'Satu pengguna hanya boleh memiliki satu akun aktif.',
            ],
          ),
          _buildTermSection(
            context,
            icon: Icons.rule,
            title: '2. Kewajiban Pengguna',
            points: [
              'Anda setuju untuk tidak menggunakan Aplikasi untuk tujuan ilegal atau yang dilarang oleh ketentuan ini.',
              'Anda tidak boleh melakukan spam, mengunggah virus, atau melakukan tindakan apa pun yang dapat merusak atau mengganggu layanan Aplikasi.',
              'Anda setuju untuk berinteraksi dengan pengguna lain dan admin secara sopan dan hormat.',
            ],
          ),
          _buildTermSection(
            context,
            icon: Icons.payment_outlined,
            title: '3. Pembayaran, Booking, dan Sewa',
            points: [
              'Semua pembayaran harus dilakukan melalui metode yang disediakan di dalam Aplikasi.',
              'Opsi "Booking" akan mengamankan kamar untuk Anda dan memerlukan pembayaran dalam batas waktu yang ditentukan (misalnya, 1 jam untuk transfer VA). Status kamar akan diubah menjadi "Booked".',
              'Opsi "Sewa Langsung" dengan pembayaran yang berhasil akan langsung mengubah status kamar menjadi "Dihuni" dan menetapkan Anda sebagai penyewa.',
              'Pembayaran tunai memerlukan konfirmasi manual dari admin sebelum status permintaan atau sewa Anda disetujui.',
            ],
          ),
          _buildTermSection(
            context,
            icon: Icons.gpp_good_outlined,
            title: '4. Keamanan dan Privasi',
            points: [
              'Kami berkomitmen untuk melindungi privasi Anda. Data pribadi Anda akan dikelola sesuai dengan Kebijakan Privasi kami.',
              'Kami tidak bertanggung jawab atas kehilangan atau kerusakan barang pribadi milik Pengguna di dalam area kost. Keamanan barang pribadi adalah tanggung jawab masing-masing Pengguna.',
            ],
          ),
          _buildTermSection(
            context,
            icon: Icons.sync_problem_outlined,
            title: '5. Batasan Tanggung Jawab',
            points: [
              'Aplikasi disediakan "sebagaimana adanya". Kami tidak menjamin bahwa Aplikasi akan selalu bebas dari kesalahan atau gangguan.',
              'Kami tidak bertanggung jawab atas perselisihan apa pun yang terjadi antara penyewa dan pemilik kost atau antara sesama penyewa.',
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Ketentuan ini terakhir diperbarui pada: 28 Juli 2024.',
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ].animate(interval: 100.ms).fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
      ),
    );
  }

  // PERBAIKAN: Setiap seksi dibungkus dengan Card untuk memberikan border
  Widget _buildTermSection(BuildContext context, {required IconData icon, required String title, required List<String> points}) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...points.map((point) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Icon(Icons.circle, size: 8, color: Colors.grey),
                  ),
                  title: Text(point, style: textTheme.bodyMedium),
                )),
          ],
        ),
      ),
    );
  }
}
