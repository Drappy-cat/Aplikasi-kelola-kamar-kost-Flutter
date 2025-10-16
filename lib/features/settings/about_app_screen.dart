import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Tentang Aplikasi',
                style: textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.secondary], // Gradasi sesuai tema
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile/profile_rizma.png'), // Gambar profil Anda
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rizma Indra Pramudya',
                      style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Bagian Tentang Saya ---
                  Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tentang Saya',
                            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
                          ),
                          const Divider(height: 24),
                          _buildInfoRow(context, 'Nama', 'Rizma Indra Pramudya'),
                          _buildInfoRow(context, 'Berkuliah di', 'Universitas Negeri Surabaya'),
                          _buildInfoRow(context, 'Prodi', 'Informatika'),
                          _buildInfoRow(context, 'NIM', '24111814117'),
                        ],
                      ),
                    ),
                  ),

                  // --- Bagian Tentang Aplikasi ---
                  Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tentang Aplikasi',
                            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
                          ),
                          const Divider(height: 24),
                          Text(
                            'Aplikasi Ri-Kost adalah solusi manajemen rumah kost berbasis mobile yang dirancang untuk menyederhanakan dan mengotomatisasi berbagai aspek pengelolaan kost. Aplikasi ini menjembatani komunikasi antara pemilik/admin kost dengan penghuni dan calon penghuni, serta menyediakan fitur-fitur esensial untuk pengalaman mengelola dan menghuni kost yang lebih baik.',
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '**Guna Aplikasi:**',
                            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Memudahkan admin dalam mengelola data kamar, penghuni, tagihan, pengaduan, dan pengumuman. Memfasilitasi calon penghuni untuk mencari dan menyewa kamar, serta penghuni untuk mengelola pembayaran, melaporkan masalah, dan mencatat kehadiran.',
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '**Fungsi & Manfaat:**',
                            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '1.  **Efisiensi:** Mengurangi beban kerja manual admin dengan otomatisasi proses.\n2.  **Transparansi:** Memberikan informasi kamar dan tagihan yang jelas bagi penghuni.\n3.  **Komunikasi:** Menyediakan saluran komunikasi terpusat untuk pengaduan dan pengumuman.\n4.  **Modernisasi:** Meningkatkan citra manajemen kost dengan teknologi digital.\n5.  **Kemudahan:** Mempermudah penghuni dalam melakukan pembayaran dan interaksi dengan admin.',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
          ),
          Expanded(
            child: Text(value, style: textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
