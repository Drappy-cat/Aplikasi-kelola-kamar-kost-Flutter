import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/complaints/admin_complaint_screen.dart';
import 'package:tes/features/home/admin_widgets/announcements_page.dart';
import 'package:tes/features/home/admin_widgets/bills_page.dart';
import 'package:tes/features/home/admin_widgets/requests_page.dart';
import 'package:tes/features/home/admin_widgets/rooms_page.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
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
              child: Icon(Icons.person),
            ),
          ),
        ),
        title: const Text('Ri-Kost - Admin Panel'),
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
                  // PERBAIKAN: Menggunakan widget yang sudah diekstrak
                  RoomsPage(rooms: state.rooms),
                  BillsPage(pendingBills: state.pendingBills),
                  RequestsPage(requests: state.requests),
                  const AdminComplaintScreen(), // Ini sudah menjadi widget terpisah, jadi kita biarkan
                  AnnouncementsPage(announcements: state.announcements),
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
        content: Form(
          key: formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Judul'), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
            const SizedBox(height: 8),
            TextFormField(controller: contentCtrl, decoration: const InputDecoration(labelText: 'Isi Pengumuman'), maxLines: 3, validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Memanggil service dan refresh data melalui BLoC
                getIt<DummyService>().addAnnouncement(title: titleCtrl.text, content: contentCtrl.text).then((_) {
                  context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData());
                });
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Publikasikan'),
          ),
        ],
      ),
    );
  }
}

// PERBAIKAN: Semua kelas widget privat (_RoomsPage, _BillsPage, dll.) telah dihapus dari file ini.
