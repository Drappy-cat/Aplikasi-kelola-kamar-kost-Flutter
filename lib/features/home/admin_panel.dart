import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/features/home/add_edit_screen.dart';
import 'package:tes/features/home/room_detail_screen.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/features/complaints/admin_complaint_screen.dart'; // Import the new admin complaint screen

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
            onTap: () => Navigator.of(context).pushNamed('/profile'),
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
            onPressed: () => Navigator.of(context).pushNamed('/notification'),
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: IndexedStack(
        index: _adminTab,
        children: [
          _roomsPage(),
          _billsPage(),
          _requestsPage(),
          const AdminComplaintScreen(), // Use the AdminComplaintScreen directly
          _announcementsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _adminTab,
        onDestinationSelected: (i) => setState(() => _adminTab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bed_outlined), label: 'Kamar'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Tagihan'),
          NavigationDestination(icon: Icon(Icons.inbox_outlined), label: 'Pengajuan'),
          NavigationDestination(icon: Icon(Icons.report_problem_outlined), label: 'Pengaduan'),
          NavigationDestination(icon: Icon(Icons.campaign_outlined), label: 'Pengumuman'),
        ],
      ),
      floatingActionButton: _getFabForTab(_adminTab),
    );
  }

  Widget? _getFabForTab(int index) {
    switch (index) {
      case 0: // Kamar
        return FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditScreen()),
            );
            setState(() {});
          },
          child: const Icon(Icons.add),
        );
      case 4: // Pengumuman
        return FloatingActionButton(
          onPressed: _showAddAnnouncementDialog,
          child: const Icon(Icons.add_alert),
        );
      default:
        return null;
    }
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
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RoomDetailScreen(room: room)),
                );
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  Widget _billsPage() {
    final pendingBills = DummyService.getPendingConfirmationBills();
    if (pendingBills.isEmpty) {
      return const Center(child: Text('Tidak ada tagihan yang menunggu konfirmasi.', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: pendingBills.length,
      itemBuilder: (context, index) {
        final bill = pendingBills[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Konfirmasi untuk Kamar ${bill.roomId}'),
            subtitle: Text('Periode: ${bill.period}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showConfirmationDetails(bill),
          ),
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
                      backgroundColor: req.status == 'Pending' ? Colors.orange.shade100 : req.status == 'Disetujui' ? Colors.green.shade100 : Colors.red.shade100,
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
                            DummyService.notifications.add(AppNotification(title: 'Pengajuan Ditolak', subtitle: 'Pengajuan ${req.type} untuk kamar ${req.roomCode ?? '-'} Anda telah ditolak.', date: DateTime.now(), icon: Icons.cancel, iconColor: Colors.red));
                          });
                        },
                        child: const Text('Tolak', style: TextStyle(color: Colors.red)),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            req.status = 'Disetujui';
                            if (req.type == 'Booking Kamar' && req.roomCode != null) {
                              final room = DummyService.findRoom(req.roomCode!);
                              if (room != null) {
                                room.status = 'Dihuni';
                                DummyService.updateRoom(room);
                                DummyService.notifications.add(AppNotification(title: 'Pengajuan Disetujui!', subtitle: 'Pengajuan sewa kamar ${room.code} Anda telah disetujui. Selamat datang!', date: DateTime.now(), icon: Icons.check_circle, iconColor: Colors.green));
                              }
                            }
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


  Widget _announcementsPage() {
    final announcements = DummyService.getLatestAnnouncements();
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(announcement.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(announcement.content),
          ),
        );
      },
    );
  }

  void _showConfirmationDetails(Bill bill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Konfirmasi - ${bill.roomId}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bill.paymentProofUrl != null) Image.asset(bill.paymentProofUrl!) else const Text('Bukti tidak tersedia.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => DummyService.rejectBill(bill.id));
              Navigator.pop(context);
            },
            child: const Text('Tolak', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => DummyService.approveBill(bill.id));
              Navigator.pop(context);
            },
            child: const Text('Setujui'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddAnnouncementDialog() async {
    final formKey = GlobalKey<FormState>();
    final titleCtrl = TextEditingController();
    final contentCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buat Pengumuman Baru'),
        content: Form(key: formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [TextFormField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Judul'), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null), const SizedBox(height: 8), TextFormField(controller: contentCtrl, decoration: const InputDecoration(labelText: 'Isi Pengumuman'), maxLines: 3, validator: (v) => v!.isEmpty ? 'Wajib diisi' : null)])),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')), ElevatedButton(onPressed: () {if (formKey.currentState!.validate()) {DummyService.addAnnouncement(title: titleCtrl.text, content: contentCtrl.text); setState(() {}); Navigator.pop(context);}}, child: const Text('Publikasikan'))],
      ),
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
}
