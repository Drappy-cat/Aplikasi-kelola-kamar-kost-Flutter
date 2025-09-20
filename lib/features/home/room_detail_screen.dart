import 'package:flutter/material.dart';
import 'package:tes/features/home/rent_options_dialog.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';

class RoomDetailScreen extends StatefulWidget {
  final Room room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showRentDialog(BuildContext context) async {
    final success = await showDialog<bool>(
      context: context,
      builder: (context) => RentOptionsDialog(room: widget.room),
    );
    if (success == true) {
      setState(() {}); // Rebuild the screen to show updated room status
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamar berhasil disewa!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider
            if (widget.room.imageUrls.isNotEmpty)
              _buildImageSlider()
            else
              Container(
                height: 250,
                color: Colors.grey[300],
                child: const Center(child: Text('Tidak ada gambar')),
              ),
            const SizedBox(height: 16),
            // Room Info Card
            Card(
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
            const SizedBox(height: 80), // Space for FAB
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

  Widget _buildImageSlider() {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.room.imageUrls.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.room.imageUrls[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    return progress == null ? child : const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.broken_image, size: 50));
                  },
                ),
              );
            },
          ),
        ),
        if (widget.room.imageUrls.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.room.imageUrls.length, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey,
                ),
              );
            }),
          ),
      ],
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
