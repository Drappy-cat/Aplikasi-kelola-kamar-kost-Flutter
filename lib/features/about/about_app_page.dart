import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Theme.of(context).colorScheme.primary, // DIUBAH: Menggunakan warna tema utama
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // DIUBAH: Agar teks dan ikon kontras
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade100.withOpacity(0.5),
              Colors.teal.shade100.withOpacity(0.5)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 20),
            // Developer Profile Section
            Center(
              child: Column(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile/profile.png'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rizma Indra Pramudya',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // About Me Section
            _buildInfoCard(
              context,
              title: 'Tentang Saya',
              children: [
                _buildInfoRow(context, 'Nama', 'Rizma Indra Pramudya'),
                _buildInfoRow(context, 'Universitas', 'Universitas Negeri Surabaya'),
                _buildInfoRow(context, 'Prodi', 'Informatika (NIM: 24111814117)'),
              ],
            ),

            const SizedBox(height: 20),

            // About Application Section
            _buildInfoCard(
              context,
              title: 'Tentang Ri-Kost',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black87, height: 1.5),
                      children: const <TextSpan>[
                        TextSpan(text: 'Ri-Kost adalah sebuah aplikasi modern yang dirancang untuk merevolusi cara pengelolaan rumah kos. Aplikasi ini berfungsi sebagai jembatan digital antara pemilik kos dan para penyewa, menyederhanakan berbagai proses administrasi dan komunikasi menjadi lebih efisien dan transparan.\n\n'),
                        TextSpan(text: 'Tujuan Utama:\n', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Memberikan kemudahan bagi pemilik untuk memantau pembayaran, mengelola data penyewa, dan menyebarkan pengumuman penting. Di sisi lain, aplikasi ini juga mempermudah penyewa untuk melakukan pembayaran, melaporkan keluhan, dan mendapatkan informasi terkini dari pemilik kos.\n\n'),
                        TextSpan(text: 'Manfaat & Fungsi:\n', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '• Manajemen Tagihan Digital\n• Riwayat Pembayaran Tercatat\n• Pengumuman Real-time\n• Pelaporan Keluhan & Masalah\n• Pusat Informasi Kos'),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.8),
              Colors.green.shade50.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
              ),
              Divider(color: Colors.green[700], thickness: 1, height: 20),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
            ),
          ),
          const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
