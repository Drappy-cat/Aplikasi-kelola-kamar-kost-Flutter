import 'package:flutter/material.dart';
import 'package:tes/features/home/room_detail_screen.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
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
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
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
          // --- IKON NOTIFIKASI BARU ---
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/notification');
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _userContent(),
    );
  }

  Widget _userContent() {
    final userRoomCode = DummyService.userRoomCode;
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
          child: Text('Daftar Kamar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  if (isSelected) {
                    setState(() {
                      _selectedStatus = status;
                    });
                  }
                },
              );
            }).toList(),
          ),
        ),
        if (filteredRooms.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text('Tidak ada kamar yang cocok dengan filter ini.'))),
        
        ...filteredRooms.map((room) => _buildRoomCard(room)),
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
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RoomDetailScreen(room: room),
            ),
          );
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(Icons.king_bed_outlined, size: 40, color: Colors.pink),
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
    return Container(); // Placeholder
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

  Future<void> _submitSimpleRequest({
    required String type,
    required String defaultNote,
    required Room room,
  }) async {
  }
}
