import 'package:flutter/material.dart';
import 'package:tes/shared/models/room.dart';

class RoomDetailScreen extends StatelessWidget {
  final Room room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kamar ${room.code}'),
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
        padding: const EdgeInsets.all(16.0),
        // Hero widget harus memiliki tag yang sama dengan di halaman sebelumnya
        child: Hero(
          tag: 'room-card-${room.code}',
          child: Material(
            type: MaterialType.transparency,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Status', room.status),
                    _buildDetailRow('Sewa Dasar', 'Rp ${room.baseRent}'),
                    _buildDetailRow('WiFi', 'Rp ${room.wifi}'),
                    _buildDetailRow('Air', 'Rp ${room.water}'),
                    _buildDetailRow('Listrik', 'Rp ${room.electricity}'),
                    _buildDetailRow('Paket Full', room.packageFull ? 'Ya' : 'Tidak'),
                    const Divider(height: 32),
                    if (room.tenantName != null) ...[
                      _buildDetailRow('Nama Penghuni', room.tenantName!),
                      _buildDetailRow('Alamat', room.tenantAddress ?? '-'),
                      _buildDetailRow('No. HP', room.tenantPhone ?? '-'),
                      _buildDetailRow('Mulai Sewa', room.rentStartDate ?? '-'),
                    ] else
                      const Center(child: Text('Kamar ini kosong', style: TextStyle(fontStyle: FontStyle.italic))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
