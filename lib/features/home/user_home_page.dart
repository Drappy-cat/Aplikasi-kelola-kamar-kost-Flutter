import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tes/features/home/bloc/user_home_bloc.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';

// Wrapper untuk menyediakan BLoC
class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeBloc()..add(const UserHomeEvent.loadData()),
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

  // Helper untuk format mata uang
  String _formatCurrency(num amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final userName = AuthService.currentUser?.fullName ?? AuthService.currentUser?.username ?? 'User';

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => context.push('/profile'),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AuthService.currentUser?.profileImageUrl != null
                  ? CachedNetworkImageProvider(AuthService.currentUser!.profileImageUrl!)
                  : null,
              child: AuthService.currentUser?.profileImageUrl == null
                  ? const Icon(Icons.person, color: Colors.pink)
                  : null,
            ),
          ),
        ),
        title: Text('$userName, selamat datang'),
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
            onPressed: () => context.push('/notification'),
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => context.push('/settings'),
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
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    if (latestAnnouncement != null) _buildAnnouncementsWidget(latestAnnouncement),
                    if (isTenant)
                      _buildTenantContent(userRoom, latestBill)
                    else
                      _buildGuestContent(allRooms),
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
      return const Center(child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Kamar Anda tidak ditemukan. Hubungi admin.'),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kamar Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildRoomCard(userRoom),
        const SizedBox(height: 24),
        const Text('Tagihan Terakhir', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildBillSummaryCard(latestBill),
        const SizedBox(height: 24),
        _buildQuickActionButtons(latestBill),
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
            .animate().fade().slideX(begin: -0.5, end: 0),
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
        
        // LayoutBuilder untuk UI Responsif
        LayoutBuilder(
          builder: (context, constraints) {
            // Tentukan breakpoint untuk mode tablet/desktop
            const double tabletBreakpoint = 600.0;

            if (constraints.maxWidth < tabletBreakpoint) {
              // Tampilan LIST untuk layar sempit (Potrait)
              return Column(
                children: filteredRooms.asMap().entries.map((entry) {
                  final index = entry.key;
                  final room = entry.value;
                  return _buildRoomCard(room)
                      .animate()
                      .fade(delay: (100 * index).ms, duration: 400.ms)
                      .slideY(begin: 0.5, end: 0);
                }).toList(),
              );
            } else {
              // Tampilan GRID untuk layar lebar (Landscape/Tablet)
              return GridView.builder(
                shrinkWrap: true, // Wajib untuk GridView di dalam ListView
                physics: const NeverScrollableScrollPhysics(), // Wajib untuk GridView di dalam ListView
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400, // Lebar maksimal setiap item grid
                  childAspectRatio: 0.85,   // Rasio lebar-tinggi kartu
                  crossAxisSpacing: 16,   // Spasi horizontal
                  mainAxisSpacing: 16,    // Spasi vertikal
                ),
                itemCount: filteredRooms.length,
                itemBuilder: (context, index) {
                  final room = filteredRooms[index];
                  return _buildRoomCard(room)
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

  // --- WIDGET-WIDGET PEMBANTU ---

  Widget _buildAnnouncementsWidget(Announcement latest) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () => context.push('/announcements'),
        child: Card(
          elevation: 3,
          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.campaign, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(latest.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.primary)),
                ]),
                const SizedBox(height: 8),
                Text(latest.content, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('Lihat Semua Pengumuman', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ).animate().fade(duration: 500.ms).slideY(begin: -0.2, end: 0),
    );
  }

  // === KARTU KAMAR MODERN ===
  Widget _buildRoomCard(Room room) {
    final price = _formatCurrency(room.baseRent + room.wifi + room.water + room.electricity + room.acCost);
    final bool isAvailable = room.status == 'Kosong';

    return Card(
      elevation: 4,
      margin: EdgeInsets.zero, // Margin diatur oleh GridView atau Column
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          await context.push('/room_detail', extra: room);
          if (mounted) context.read<UserHomeBloc>().add(const UserHomeEvent.loadData());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Animation untuk transisi gambar yang mulus
            Hero(
              tag: 'room-image-${room.code}',
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  // Gambar Kamar
                  CachedNetworkImage(
                    imageUrl: room.imageUrls.isNotEmpty ? room.imageUrls.first : 'https://i.pravatar.cc/400?img=9', // Fallback image
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(height: 180, color: Colors.grey[200]),
                    errorWidget: (context, url, error) => Container(height: 180, color: Colors.grey[200], child: const Icon(Icons.broken_image)),
                  ),
                  // Chip Status di atas gambar
                  if (room.status.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Text(room.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        backgroundColor: isAvailable ? Colors.green.withOpacity(0.8) : Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      ),
                    ),
                ],
              ),
            ),
            // Detail Teks di bawah gambar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kamar ${room.code}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(price, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Ukuran: ${room.dimensions}', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillSummaryCard(Bill? latestBill) {
    if (latestBill == null) {
      return const Card(child: ListTile(leading: Icon(Icons.receipt_long_outlined), title: Text('Belum ada riwayat tagihan')));
    }

    final Color statusColor;
    final String statusText;
    switch (latestBill.status) {
      case 'Lunas': statusColor = Colors.green; statusText = 'Lunas'; break;
      case 'Menunggu Konfirmasi': statusColor = Colors.orange; statusText = 'Menunggu Konfirmasi'; break;
      default: statusColor = Colors.red; statusText = 'Belum Dibayar';
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(Icons.receipt_long_outlined, color: Theme.of(context).colorScheme.primary, size: 40),
        title: Text('Tagihan ${latestBill.period}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Total: ${_formatCurrency(latestBill.amount)}'),
        trailing: Chip(
          label: Text(statusText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: statusColor,
        ),
        onTap: () => context.push('/user_bills'),
      ),
    );
  }

  Widget _buildQuickActionButtons(Bill? latestBill) {
    bool canPay = latestBill != null && latestBill.status == 'Belum Dibayar';

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.payment),
            label: const Text('Bayar Tagihan'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: canPay ? Theme.of(context).colorScheme.primary : Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: canPay ? () => context.push('/user_bills') : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.report_problem_outlined),
            label: const Text('Lapor Kerusakan'),
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
            onPressed: () => context.push('/report_issue'), // Arahkan ke halaman baru
          ),
        ),
      ],
    );
  }
}
