import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/home/rent_options_dialog.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

class RoomDetailScreen extends StatefulWidget {
  final Room room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  late Room _currentRoom;
  // Mengambil instance service dari GetIt
  final DummyService _dummyService = getIt<DummyService>();
  final AuthService _authService = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
    _currentRoom = widget.room;
  }

  String _formatCurrency(num amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  Future<void> _showRentDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => RentOptionsDialog(room: _currentRoom),
    );

    if (result == true && mounted) {
      // Menggunakan instance service
      final updatedRoom = _dummyService.findRoom(_currentRoom.code);
      if (updatedRoom != null) {
        setState(() {
          _currentRoom = updatedRoom;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan instance service
    final bool isAdmin = _authService.currentUser?.role == 'admin';
    final bool isOccupied = _currentRoom.tenantName != null;
    final bool isAvailable = _currentRoom.status == 'Kosong';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Kamar ${_currentRoom.code}', style: const TextStyle(shadows: [Shadow(blurRadius: 8)])),
              background: Hero(
                tag: 'room-image-${_currentRoom.code}',
                child: Image.asset(
                  _currentRoom.imageUrls.isNotEmpty ? _currentRoom.imageUrls.first : 'assets/logo/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200], child: const Icon(Icons.broken_image)),
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
                  _buildSectionHeader('Detail Kamar'),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        _buildInfoTile(Icons.aspect_ratio_outlined, 'Ukuran', _currentRoom.dimensions),
                        _buildInfoTile(Icons.paid_outlined, 'Harga Sewa', _formatCurrency(_currentRoom.totalPrice)),
                        _buildInfoTile(
                          Icons.event_available_outlined,
                          'Status',
                          _currentRoom.status,
                          valueColor: isAvailable ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (isAdmin && isOccupied)
                    _buildSectionHeader('Detail Penghuni'),
                  if (isAdmin && isOccupied)
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          _buildInfoTile(Icons.person_outline, 'Nama', _currentRoom.tenantName!),
                          _buildInfoTile(Icons.home_outlined, 'Alamat Asal', _currentRoom.tenantAddress ?? 'N/A'),
                          _buildInfoTile(Icons.phone_outlined, 'No. Telepon', _currentRoom.tenantPhone ?? 'N/A'),
                          _buildInfoTile(Icons.date_range_outlined, 'Mulai Sewa', _currentRoom.rentStartDate ?? 'N/A'),
                        ],
                      ),
                    ),
                  if (isAdmin && isOccupied) const SizedBox(height: 24),

                  _buildSectionHeader('Fasilitas'),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        _buildInfoTile(Icons.wifi, 'Wi-Fi', _formatCurrency(_currentRoom.wifi)),
                        _buildInfoTile(Icons.water_drop_outlined, 'Air', _formatCurrency(_currentRoom.water)),
                        _buildInfoTile(Icons.electrical_services_outlined, 'Listrik', _formatCurrency(_currentRoom.electricity)),
                        if (_currentRoom.acCost > 0)
                          _buildInfoTile(Icons.ac_unit, 'AC', _formatCurrency(_currentRoom.acCost)),
                      ],
                    ),
                  ),
                ].animate(interval: 100.ms).fade(duration: 300.ms).slideY(begin: 0.2, end: 0),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: (isAvailable && !isAdmin)
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _showRentDialog,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Sewa Kamar Ini'),
              ),
            )
          : null,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value, {Color? valueColor}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: valueColor),
      ),
    );
  }
}
