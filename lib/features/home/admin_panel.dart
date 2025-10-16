import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/activity_log/activity_log_screen.dart';
import 'package:tes/features/chat/admin_chat_list_screen.dart';
import 'package:tes/features/complaints/admin_complaint_screen.dart';
import 'package:tes/features/home/admin_widgets/announcements_page.dart';
import 'package:tes/features/home/admin_widgets/bills_page.dart';
import 'package:tes/features/home/admin_widgets/requests_page.dart';
import 'package:tes/features/home/admin_widgets/rooms_page.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/features/reports/report_screen.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/notification_service.dart';
import 'package:tes/shared/services/theme_service.dart';
import 'package:tes/shared/widgets/app_drawer.dart';

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

class AdminPanelView extends StatelessWidget {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();
    final bloc = context.read<AdminPanelBloc>();
    final state = context.watch<AdminPanelBloc>().state;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        // PERBAIKAN: Menggunakan `shape` untuk membuat sudut melengkung.
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 100, // Menambah tinggi AppBar
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
      drawer: const AppDrawer(),
      // PERBAIKAN: Menghapus Stack dan Container latar belakang yang tidak perlu.
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                bloc.add(const AdminPanelEvent.loadData());
              },
              child: IndexedStack(
                index: state.activeTabIndex,
                children: [
                  const ReportScreen(),
                  RoomsPage(rooms: state.rooms),
                  BillsPage(pendingBills: state.pendingBills),
                  RequestsPage(requests: state.requests),
                  const AdminComplaintScreen(),
                  const AdminChatListScreen(),
                  AnnouncementsPage(announcements: state.announcements),
                  const ActivityLogScreen(),
                ],
              ),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.activeTabIndex,
        onDestinationSelected: (index) => bloc.add(AdminPanelEvent.changeTab(index)),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), label: 'Laporan'),
          NavigationDestination(icon: Icon(Icons.bed_outlined), label: 'Kamar'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Tagihan'),
          NavigationDestination(icon: Icon(Icons.inbox_outlined), label: 'Pengajuan'),
          NavigationDestination(icon: Icon(Icons.report_problem_outlined), label: 'Pengaduan'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.campaign_outlined), label: 'Pengumuman'),
          NavigationDestination(icon: Icon(Icons.history_toggle_off_outlined), label: 'Log'),
        ],
      ),
      floatingActionButton: _getFabForTab(context, state.activeTabIndex),
    );
  }

  Widget? _getFabForTab(BuildContext context, int index) {
    switch (index) {
      case 2:
        return FloatingActionButton(
          onPressed: () => _showGenerateBillsDialog(context),
          tooltip: 'Buat Tagihan Bulanan',
          child: const Icon(Icons.add_card),
        );
      case 6:
        return FloatingActionButton(
          onPressed: () => _showAddAnnouncementDialog(context),
          tooltip: 'Buat Pengumuman Baru',
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
                final title = titleCtrl.text;
                final content = contentCtrl.text;
                getIt<DummyService>().addAnnouncement(title: title, content: content).then((_) {
                  context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData());
                  getIt<NotificationService>().showNotification('Pengumuman Baru: $title', content);
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

  Future<void> _showGenerateBillsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Buat Tagihan Bulanan'),
        content: const Text('Apakah Anda yakin ingin membuat tagihan untuk semua penghuni aktif untuk bulan ini? Aksi ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              final newBillsCount = await getIt<DummyService>().generateMonthlyBills();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Berhasil membuat $newBillsCount tagihan baru.'),
                    backgroundColor: Colors.green,
                  ),
                );
                context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData());
              }
            },
            child: const Text('Ya, Buat Tagihan'),
          ),
        ],
      ),
    );
  }
}
