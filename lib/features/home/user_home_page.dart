import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/home/bloc/user_home_bloc.dart';
import 'package:tes/features/home/widgets/announcement_widget.dart';
import 'package:tes/features/home/widgets/bill_summary_card.dart';
import 'package:tes/features/home/widgets/room_card.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/widgets/app_drawer.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserHomeBloc>()..add(const UserHomeEvent.loadData()),
      child: const UserHomeView(),
    );
  }
}

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  String _selectedStatus = 'Semua';

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();
    final userName = authService.currentUser?.fullName ?? authService.currentUser?.username ?? 'User';
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hai, $userName'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        // PERBAIKAN: Menggunakan `shape` untuk membuat sudut melengkung.
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 100, // Menambah tinggi AppBar agar lengkungan terlihat bagus
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.notification),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      // PERBAIKAN: Menghapus Stack dan Container latar belakang yang tidak perlu.
      body: BlocBuilder<UserHomeBloc, UserHomeState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Terjadi Kesalahan: $message', textAlign: TextAlign.center),
              ),
            ),
            loaded: (isTenant, latestAnnouncement, userRoom, latestBill, allRooms) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserHomeBloc>().add(const UserHomeEvent.loadData());
                },
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        if (latestAnnouncement != null) AnnouncementWidget(latestAnnouncement: latestAnnouncement),
                        if (isTenant)
                          _buildTenantContent(context, userRoom, latestBill)
                        else
                          _buildGuestContent(allRooms),
                        const SizedBox(height: 80),
                      ],
                    ),
                    if (isTenant)
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton.extended(
                          onPressed: () => context.push('${AppRoutes.chat}/admin'),
                          label: const Text('Hubungi Admin'),
                          icon: const Icon(Icons.chat_bubble_outline),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTenantContent(BuildContext context, Room? userRoom, Bill? latestBill) {
    if (userRoom == null) {
      return const Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Kamar Anda tidak ditemukan. Hubungi admin.'),
        ),
      );
    }
    final bool canPay = latestBill != null && latestBill.status == 'Belum Dibayar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildQuickAction(context, icon: Icons.qr_code_scanner, label: 'Scan Hadir', onTap: () => context.push(AppRoutes.scanActivity)),
              ),
              Expanded(
                child: _buildQuickAction(context, icon: Icons.payment, label: 'Bayar Tagihan', onTap: canPay ? () => context.push(AppRoutes.userBills) : null),
              ),
              Expanded(
                child: _buildQuickAction(context, icon: Icons.report_problem_outlined, label: 'Lapor Masalah', onTap: () => context.push(AppRoutes.reportIssue)),
              ),
            ],
          ),
        ),
        const Divider(height: 32),
        const Text('Kamar Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        RoomCard(room: userRoom),
        const SizedBox(height: 24),
        const Text('Tagihan Terakhir', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BillSummaryCard(latestBill: latestBill),
      ],
    ).animate().fade();
  }

  Widget _buildQuickAction(BuildContext context, {required IconData icon, required String label, VoidCallback? onTap}) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isEnabled = onTap != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: onTap,
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(icon, color: isEnabled ? colorScheme.primary : Colors.grey, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildGuestContent(List<Room> allRooms) {
    final filteredRooms = _selectedStatus == 'Semua'
        ? allRooms
        : allRooms.where((r) => r.status == _selectedStatus).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daftar Kamar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            .animate()
            .fade()
            .slideX(begin: -0.5, end: 0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            spacing: 8.0,
            children: ['Semua', 'Kosong', 'Booked', 'Dihuni'].map((status) {
              return ChoiceChip(
                label: Text(status),
                selected: _selectedStatus == status,
                onSelected: (isSelected) {
                  if (isSelected) setState(() => _selectedStatus = status);
                },
              );
            }).toList(),
          ),
        ).animate().fade(delay: 200.ms).slideX(begin: -0.5, end: 0),
        if (filteredRooms.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text('Tidak ada kamar yang cocok.'))),
        LayoutBuilder(
          builder: (context, constraints) {
            const double tabletBreakpoint = 600.0;

            if (constraints.maxWidth < tabletBreakpoint) {
              return Column(
                children: filteredRooms.asMap().entries.map((entry) {
                  final index = entry.key;
                  final room = entry.value;
                  return RoomCard(room: room)
                      .animate()
                      .fade(delay: (100 * index).ms, duration: 400.ms)
                      .slideY(begin: 0.5, end: 0);
                }).toList(),
              );
            } else {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredRooms.length,
                itemBuilder: (context, index) {
                  final room = filteredRooms[index];
                  return RoomCard(room: room)
                      .animate()
                      .fade(delay: (100 * index).ms, duration: 400.ms)
                      .slideY(begin: 0.5, end: 0);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
