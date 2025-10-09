import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/complaints/admin_complaint_screen.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

// Wrapper untuk menyediakan BLoC
class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminPanelBloc>()..add(const AdminPanelEvent.loadData()),
      child: const AdminPanelView(),
    );
  }
}

// Widget utama yang menampilkan UI
class AdminPanelView extends StatelessWidget {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();
    final bloc = context.read<AdminPanelBloc>();
    final state = context.watch<AdminPanelBloc>().state;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => context.push(AppRoutes.profile),
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
            onPressed: () => context.push(AppRoutes.notification),
            icon: const Icon(Icons.notifications_outlined),
          ),
          AnimatedBuilder(
            animation: themeService,
            builder: (context, child) {
              return IconButton(
                onPressed: () => themeService.toggleTheme(),
                icon: Icon(themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              );
            },
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                bloc.add(const AdminPanelEvent.loadData());
              },
              child: IndexedStack(
                index: state.activeTabIndex,
                children: [
                  _RoomsPage(rooms: state.rooms),
                  _BillsPage(pendingBills: state.pendingBills),
                  _RequestsPage(requests: state.requests),
                  const AdminComplaintScreen(),
                  _AnnouncementsPage(announcements: state.announcements),
                ],
              ),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.activeTabIndex,
        onDestinationSelected: (index) => bloc.add(AdminPanelEvent.changeTab(index)),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bed_outlined), label: 'Kamar'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Tagihan'),
          NavigationDestination(icon: Icon(Icons.inbox_outlined), label: 'Pengajuan'),
          NavigationDestination(icon: Icon(Icons.report_problem_outlined), label: 'Pengaduan'),
          NavigationDestination(icon: Icon(Icons.campaign_outlined), label: 'Pengumuman'),
        ],
      ),
      floatingActionButton: _getFabForTab(context, state.activeTabIndex),
    );
  }

  Widget? _getFabForTab(BuildContext context, int index) {
    switch (index) {
      case 4: // Pengumuman
        return FloatingActionButton(
          onPressed: () => _showAddAnnouncementDialog(context),
          child: const Icon(Icons.add_alert),
        );
      default:
        return null;
    }
  }

  Future<void> _showAddAnnouncementDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final titleCtrl = TextEditingController();
    final contentCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Buat Pengumuman Baru'),
        content: Form(key: formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [TextFormField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Judul'), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null), const SizedBox(height: 8), TextFormField(controller: contentCtrl, decoration: const InputDecoration(labelText: 'Isi Pengumuman'), maxLines: 3, validator: (v) => v!.isEmpty ? 'Wajib diisi' : null)])),
        actions: [TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Batal')), ElevatedButton(onPressed: () {
          if (formKey.currentState!.validate()) {
            getIt<DummyService>().addAnnouncement(title: titleCtrl.text, content: contentCtrl.text);
            context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData()); // Refresh data
            Navigator.of(dialogContext).pop();
          }
        }, child: const Text('Publikasikan'))],
      ),
    );
  }
}

// --- WIDGET-WIDGET HALAMAN ---

class _RoomsPage extends StatelessWidget {
  final List<Room> rooms;
  const _RoomsPage({required this.rooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text('Kamar ${room.code}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Status: ${room.status}'), if (room.tenantName != null) Text('Penghuni: ${room.tenantName}')]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await context.push(AppRoutes.roomDetail, extra: room);
              context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData());
            },
          ),
        );
      },
    );
  }
}

class _BillsPage extends StatelessWidget {
  final List<Bill> pendingBills;
  const _BillsPage({required this.pendingBills});

  @override
  Widget build(BuildContext context) {
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
            onTap: () => _showConfirmationDetails(context, bill),
          ),
        );
      },
    );
  }

  void _showConfirmationDetails(BuildContext context, Bill bill) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Detail Konfirmasi - ${bill.roomId}'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [if (bill.paymentProofUrl != null) Image.network(bill.paymentProofUrl!) else const Text('Bukti tidak tersedia (Pembayaran Tunai).')]),
        actions: [
          TextButton(onPressed: () {
            getIt<DummyService>().rejectBill(bill.id).then((_) => context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData()));
            Navigator.of(dialogContext).pop();
          }, child: const Text('Tolak', style: TextStyle(color: Colors.red))),
          ElevatedButton(onPressed: () {
            getIt<DummyService>().approveBill(bill.id).then((_) => context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData()));
            Navigator.of(dialogContext).pop();
          }, child: const Text('Setujui')),
        ],
      ),
    );
  }
}

class _RequestsPage extends StatelessWidget {
  final List<Request> requests;
  const _RequestsPage({required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(child: Text('Tidak ada pengajuan baru.', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(req.type, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              _row('User', req.userName ?? '–'),
              _row('Kamar', req.roomCode ?? '–'),
              _row('Tanggal', req.date),
              _row('Catatan', req.note),
              const SizedBox(height: 8),
              Row(children: [const Text('Status: ', style: TextStyle(color: Colors.black54)), Chip(label: Text(req.status), backgroundColor: req.status == 'Pending' ? Colors.orange.shade100 : req.status == 'Disetujui' ? Colors.green.shade100 : Colors.red.shade100)]),
              const SizedBox(height: 8),
              if (req.status == 'Pending')
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // PERBAIKAN: Tombol sekarang hanya mengirim event
                  TextButton(onPressed: () {
                    context.read<AdminPanelBloc>().add(AdminPanelEvent.processRequest(req, false));
                  }, child: const Text('Tolak', style: TextStyle(color: Colors.red))),
                  const SizedBox(width: 8),
                  FilledButton(onPressed: () {
                    context.read<AdminPanelBloc>().add(AdminPanelEvent.processRequest(req, true));
                  }, child: const Text('Setujui')),
                ]),
            ]),
          ),
        );
      },
    );
  }

  Widget _row(String k, String v) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Row(children: [SizedBox(width: 140, child: Text(k, style: const TextStyle(color: Colors.black54))), Expanded(child: Text(v))]));
  }
}

class _AnnouncementsPage extends StatelessWidget {
  final List<Announcement> announcements;
  const _AnnouncementsPage({required this.announcements});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(title: Text(announcement.title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(announcement.content)),
        );
      },
    );
  }
}
