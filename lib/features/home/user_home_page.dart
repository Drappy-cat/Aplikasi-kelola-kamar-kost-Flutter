import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/home/bloc/user_home_bloc.dart';
import 'package:tes/features/home/widgets/announcement_widget.dart';
import 'package:tes/features/home/widgets/bill_summary_card.dart';
import 'package:tes/features/home/widgets/quick_action_buttons.dart';
import 'package:tes/features/home/widgets/room_card.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart';

// Wrapper untuk menyediakan BLoC
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

// Widget utama yang menampilkan UI
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
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => context.push(AppRoutes.profile),
            child: CircleAvatar(
              backgroundColor: colorScheme.onPrimary.withOpacity(0.1),
              backgroundImage: authService.currentUser?.profileImageUrl != null
                  ? NetworkImage(authService.currentUser!.profileImageUrl!)
                  : null,
              child: authService.currentUser?.profileImageUrl == null
                  ? Icon(Icons.person, color: colorScheme.onPrimary)
                  : null,
            ),
          ),
        ),
        title: Text('Hai, $userName'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.notification),
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
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
                child: Stack( // Gunakan Stack untuk menumpuk FAB di atas ListView
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        if (latestAnnouncement != null) AnnouncementWidget(latestAnnouncement: latestAnnouncement),
                        if (isTenant)
                          _buildTenantContent(userRoom, latestBill)
                        else
                          _buildGuestContent(allRooms),
                        // Beri ruang di bawah agar tidak tertutup FAB
                        const SizedBox(height: 80),
                      ],
                    ),
                    if (isTenant)
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            // Saat penghuni chat, lawan bicaranya adalah admin
                            context.push('${AppRoutes.chat}/admin');
                          },
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

  // --- KONTEN UNTUK PENGHUNI ---
  Widget _buildTenantContent(Room? userRoom, Bill? latestBill) {
    if (userRoom == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Kamar Anda tidak ditemukan. Hubungi admin.'),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kamar Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        RoomCard(room: userRoom),
        const SizedBox(height: 24),
        const Text('Tagihan Terakhir', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BillSummaryCard(latestBill: latestBill),
        const SizedBox(height: 24),
        QuickActionButtons(latestBill: latestBill),
      ],
    ).animate().fade();
  }

  // --- KONTEN UNTUK TAMU (RESPONSIVE) ---
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
