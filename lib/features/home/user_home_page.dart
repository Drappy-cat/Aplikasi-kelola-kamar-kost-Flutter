import 'package:flutter/material.dart';
import 'package:tes/features/home/room_detail_screen.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String _selectedStatus = 'Semua';

  @override
  Widget build(BuildContext context) {
    final userName = AuthService.currentUser?.fullName ?? AuthService.currentUser?.username ?? 'User';
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
            onPressed: () => Navigator.of(context).pushNamed('/notification'),
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAnnouncementsWidget(),
          Expanded(child: _userContent()),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsWidget() {
    final announcements = DummyService.getLatestAnnouncements();
    if (announcements.isEmpty) {
      return const SizedBox.shrink(); // Tidak menampilkan apa-apa jika tidak ada pengumuman
    }

    final latest = announcements.first;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/announcements'), // Navigate to AnnouncementScreen
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        elevation: 3,
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.campaign, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    latest.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(latest.content, style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Lihat Semua Pengumuman',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userContent() {
    // Logika ini tetap sama, menentukan apakah pengguna sudah punya kamar atau belum
    final userRoomCode = AuthService.currentUser?.roomId;
    if (userRoomCode == null) {
      return _allRoomsPage();
    } else {
      final room = DummyService.findRoom(userRoomCode);
      if (room == null) {
        return const Center(child: Text('Kamar Anda tidak ditemukan.'));
      }
      return _userRoomInfo(room);
    }
  }

  Widget _allRoomsPage() {
    final List<Room> filteredRooms;
    if (_selectedStatus == 'Semua') {
      filteredRooms = DummyService.rooms;
    } else {
      filteredRooms = DummyService.rooms.where((r) => r.status == _selectedStatus).toList();
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text('Daftar Kamar Tersedia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
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
        ),
        if (filteredRooms.isEmpty) const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text('Tidak ada kamar yang cocok.'))),
        ...filteredRooms.map((room) => _buildRoomCard(room)),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Anda harus memiliki kamar untuk melihat tagihan.')),
              );
            },
            child: const Text('Lihat Tagihan Saya'),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomCard(Room room) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomDetailScreen(room: room)));
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(Icons.king_bed_outlined, size: 40, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kamar ${room.code}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Rp ${DummyService.computeTotalForRoom(room)} / bulan'),
                    Text('Status: ${room.status}', style: TextStyle(color: room.status == 'Kosong' ? Colors.green : (room.status == 'Booked' ? Colors.orange : Colors.red), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userRoomInfo(Room room) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Anda adalah penghuni kamar:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            _buildRoomCard(room),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/user_bills');
              },
              child: const Text('Lihat Tagihan Saya'),
            ),
          ],
        ),
      ),
    );
  }
}
