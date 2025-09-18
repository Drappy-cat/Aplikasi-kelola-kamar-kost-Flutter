import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/features/home/add_edit_screen.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _adminTab = 0;

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = AuthService.currentUser?.role == 'admin';

    if (isAdmin) {
      return _buildAdminPanel();
    } else {
      return _buildUserHomePage();
    }
  }

  // =======================================================================
  // ============================ PANEL ADMIN ============================
  // =======================================================================
  Widget _buildAdminPanel() {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.pink),
            ),
          ),
        ),
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
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: IndexedStack(
        index: _adminTab,
        children: [
          _roomsPage(),
          _billsPage(),
          _requestsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _adminTab,
        onDestinationSelected: (i) => setState(() => _adminTab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bed_outlined), label: 'Kamar'),
          NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined), label: 'Tagihan'),
          NavigationDestination(
              icon: Icon(Icons.inbox_outlined), label: 'Pengajuan'),
        ],
      ),
      // DIUBAH: Menambahkan FloatingActionButton hanya di tab Kamar
      floatingActionButton: _adminTab == 0
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddEditScreen()),
                );
                setState(() {}); // Refresh UI setelah kembali
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

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
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter modalState) {
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
                        _buildDetailRow('Alamat', room.tenantAddress ?? '-'),
                        _buildDetailRow('No. HP', room.tenantPhone ?? '-'),
                      ],
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          // DIUBAH: Menambahkan tombol Edit dan Hapus
                          FilledButton.icon(
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Edit Kamar'),
                            onPressed: () async {
                              Navigator.pop(context); // Tutup bottom sheet
                              await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => AddEditScreen(room: room)),
                              );
                              setState(() {}); // Refresh UI
                            },
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            label: const Text('Hapus Kamar', style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Konfirmasi Hapus'),
                                  content: Text('Apakah Anda yakin ingin menghapus kamar ${room.code}?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
                                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
                                  ],
                                ),
                              ) ?? false;

                              if (confirm) {
                                setState(() {
                                  DummyService.deleteRoom(room.code);
                                });
                                Navigator.pop(context); // Tutup bottom sheet
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _billsPage() {
    // ... (Kode tidak berubah)
    return Container();
  }

  void _showBillDetails(Bill bill) {
    // ... (Kode tidak berubah)
  }

  void _showCreateBillDialog(Room r) {
    // ... (Kode tidak berubah)
  }

  Widget _requestsPage() {
    // ... (Kode tidak berubah)
    return Container();
  }

  // =======================================================================
  // ============================ HALAMAN USER =============================
  // =======================================================================
  Widget _buildUserHomePage() {
    // ... (Kode tidak berubah)
    return Container();
  }

  Widget _userContent() {
    // ... (Kode tidak berubah)
    return Container();
  }

  Widget _availableRoomsPage() {
    // ... (Kode tidak berubah)
    return Container();
  }

  Widget _bookingForm() {
    // ... (Kode tidak berubah)
    return Container();
  }

  Widget _userRoomInfo(Room room) {
    // ... (Kode tidak berubah)
    return Container();
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(k, style: const TextStyle(color: Colors.black54))),
          Expanded(child: Text(v)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: const TextStyle(color: Colors.grey)), Text(value)],
      ),
    );
  }

  Future<void> _submitSimpleRequest({
    required String type,
    required String defaultNote,
    required Room room,
  }) async {
    // ... (Kode tidak berubah)
  }
}
