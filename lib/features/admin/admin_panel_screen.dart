import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/dummy_service.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kost - Admin Panel'),
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
        actions: [
          IconButton(
            onPressed: () {
              MyApp.of(context)?.toggleTheme();
            },
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: IndexedStack(
        index: _tab,
        children: [
          _roomsPage(),
          _billsPage(),
          _requestsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bed_outlined), label: 'Kamar'),
          NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined), label: 'Tagihan'),
          NavigationDestination(
              icon: Icon(Icons.inbox_outlined), label: 'Pengajuan'),
        ],
      ),
    );
  }

  // =================== KAMAR ===================
  Widget _roomsPage() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: DummyService.rooms.length,
      itemBuilder: (context, index) {
        final room = DummyService.rooms[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text('Kamar ${room.code}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${room.status}'),
                if (room.tenantName != null) Text('Penghuni: ${room.tenantName}'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showRoomDetails(room),
          ),
        );
      },
    );
  }

  void _showRoomDetails(Room room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detail Kamar ${room.code}', style: Theme.of(context).textTheme.headlineSmall),
                  const Divider(),
                  _buildDetailRow('Status', room.status),
                  _buildDetailRow('Sewa Dasar', 'Rp ${room.baseRent}'),
                  _buildDetailRow('WiFi', 'Rp ${room.wifi}'),
                  _buildDetailRow('Air', 'Rp ${room.water}'),
                  _buildDetailRow('Listrik', 'Rp ${room.electricity}'),
                  _buildDetailRow('Paket Full', room.packageFull ? 'Ya' : 'Tidak'),
                  const Divider(),
                  if (room.tenantName != null) ...[
                    _buildDetailRow('Nama Penghuni', room.tenantName!),
                    _buildDetailRow('Alamat', room.tenantAddress ?? '-')
                  ]
                ]
              )
            );
          }
        );
      }
    );
  }
}
