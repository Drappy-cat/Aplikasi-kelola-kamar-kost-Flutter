// ===== 5. HALAMAN DETAIL =====
// Halaman ini menampilkan semua informasi rinci tentang satu kamar yang dipilih.
// Halaman ini dapat diakses oleh admin (dari daftar kamar di AdminPanel) dan oleh pengguna
// (dari daftar kamar di UserHomePage).

import 'package:flutter/material.dart';
import 'package:tes/features/home/rent_options_dialog.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/widgets/image_carousel.dart';

class RoomDetailScreen extends StatefulWidget {
  // Menerima satu objek `Room` sebagai parameter. Ini adalah data yang akan ditampilkan.
  final Room room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  // Fungsi untuk menampilkan dialog opsi sewa
  void _showRentDialog(BuildContext context) async {
    final success = await showDialog<bool>(
      context: context,
      builder: (context) => RentOptionsDialog(room: widget.room),
    );
    if (success == true) {
      setState(() {}); // Refresh halaman untuk menampilkan status kamar yang baru
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamar berhasil disewa!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Logika untuk menentukan apakah tombol "Sewa" harus ditampilkan.
    // Tombol hanya muncul jika kamar berstatus "Kosong" DAN pengguna bukan admin.
    final bool canRent = widget.room.status == 'Kosong' && AuthService.currentUser?.role != 'admin';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kamar ${widget.room.code}'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan galeri gambar yang bisa digeser.
            // Ini adalah widget kustom yang telah kita buat sebelumnya.
            ImageCarousel(imageUrls: widget.room.imageUrls),
            const SizedBox(height: 16),
            // Kartu yang berisi informasi detail kamar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Kamar ${widget.room.code}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 24),
                      _buildDetailRow('Dimensi', widget.room.dimensions),
                      _buildDetailRow('Status', widget.room.status),
                      if (widget.room.tenantName != null)
                        _buildDetailRow('Penyewa', widget.room.tenantName!),
                      const Divider(height: 24),
                      Text(
                        'Fasilitas & Biaya',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow('Sewa Dasar', 'Rp ${widget.room.baseRent}'),
                      _buildDetailRow('WiFi', '10 Mbps'),
                      _buildDetailRow('Air', widget.room.packageFull ? 'Gratis' : 'Bayar sendiri (Rp ${widget.room.water})'),
                      _buildDetailRow('Listrik', widget.room.packageFull ? 'Gratis' : 'Bayar sendiri (Rp ${widget.room.electricity})'),
                      _buildDetailRow('AC', 'Tersedia (opsional)'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80), // Memberi ruang untuk FloatingActionButton
          ],
        ),
      ),
      floatingActionButton: canRent
          ? FloatingActionButton.extended(
              onPressed: () => _showRentDialog(context),
              label: const Text('Sewa Kamar Ini'),
              icon: const Icon(Icons.shopping_cart_checkout),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Helper widget untuk membuat baris detail agar kode tidak berulang
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          const Text(': '),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
