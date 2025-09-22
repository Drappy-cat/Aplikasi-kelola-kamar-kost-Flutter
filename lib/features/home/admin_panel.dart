// ===== 10. ADMIN PANEL =====
// Ini adalah halaman dasbor utama yang dilihat oleh pengguna dengan peran (role) 'admin'.
// Halaman ini berisi tiga tab utama: Kamar, Tagihan, dan Pengajuan,
// yang memungkinkan admin untuk mengelola seluruh data aplikasi.

import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/features/home/add_edit_screen.dart';
import 'package:tes/features/home/room_detail_screen.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/dummy_service.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _adminTab = 0;

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Ri-Kost - Admin Panel'),
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
      // Tombol Aksi Mengambang (FAB) hanya muncul di tab Kamar (indeks 0)
      // untuk menambahkan kamar baru.
      floatingActionButton: _adminTab == 0
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddEditScreen()),
                );
                setState(() {});
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
        return Hero(
          tag: 'room-card-${room.code}',
          child: Card(
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoomDetailScreen(room: room),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _billsPage() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: DummyService.bills.length,
      itemBuilder: (context, index) {
        final bill = DummyService.bills[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text('Tagihan ${bill.roomCode} - ${bill.month}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total: Rp ${bill.total}'),
                Text('Status: ${bill.status}'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showBillDetails(bill),
          ),
        );
      },
    );
  }

  void _showBillDetails(Bill bill) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detail Tagihan ${bill.roomCode}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Bulan', bill.month),
              _buildDetailRow('Total', 'Rp ${bill.total}'),
              _buildDetailRow('Status', bill.status),
              if (bill.method != null) _buildDetailRow('Metode', bill.method!),
              if (bill.channel != null) _buildDetailRow('Channel', bill.channel!),
            ],
          ),
          actions: [
            if (bill.status == 'Belum Dibayar')
              TextButton(
                onPressed: () {
                  setState(() {
                    bill.status = 'Lunas';
                  });
                  Navigator.pop(context);
                },
                child: const Text('Tandai Lunas'),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _requestsPage() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: DummyService.requests.length,
      itemBuilder: (context, index) {
        final req = DummyService.requests[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(req.type, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                _row('User', req.userName ?? '–'),
                _row('Kamar', req.roomCode ?? '–'),
                _row('Tanggal', req.date),
                _row('Catatan', req.note),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Status: ', style: TextStyle(color: Colors.black54)),
                    Chip(
                      label: Text(req.status),
                      backgroundColor: req.status == 'Pending'
                          ? Colors.orange.shade100
                          : req.status == 'Disetujui'
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (req.status == 'Pending')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            req.status = 'Ditolak';
                          });
                        },
                        child: const Text('Tolak', style: TextStyle(color: Colors.red)),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            req.status = 'Disetujui';
                          });
                        },
                        child: const Text('Setujui'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
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
}
