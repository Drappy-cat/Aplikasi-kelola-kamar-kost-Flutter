
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  // State untuk melacak filter status kamar yang dipilih pengguna
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
      // Jika belum punya kamar, tampilkan daftar semua kamar.
      return _allRoomsPage();
    } else {
      // Jika sudah punya kamar, tampilkan info spesifik kamar tersebut.
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
            children: ['Semua', 'Kosong', 'Dihuni'].map((status) {
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
        const SizedBox(height: 24),
        _bookingForm(),
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RoomDetailScreen(room: room),
            ),
          );
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
                    Text('Status: ${room.status}', style: TextStyle(color: room.status == 'Kosong' ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
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

  Widget _bookingForm() {
    final formKey = GlobalKey<FormState>();
    Room? selectedRoom;
    final name = TextEditingController(text: AuthService.currentUser?.fullName ?? '');
    final address = TextEditingController();
    final phone = TextEditingController();
    final TextEditingController _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

    final available = DummyService.rooms.where((r) => r.status == 'Kosong').toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ajukan Kamar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              DropdownButtonFormField<Room>(
                value: selectedRoom,
                items: available
                    .map((r) => DropdownMenuItem(value: r, child: Text('Kamar ${r.code} • Rp ${DummyService.computeTotalForRoom(r)}')))
                    .toList(),
                onChanged: (v) => selectedRoom = v!,
                validator: (v) => v == null ? 'Pilih kamar' : null,
                decoration: const InputDecoration(labelText: 'Kamar'),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final r = selectedRoom!;
                    DummyService.userRoomCode = r.code;
                    DummyService.userName = name.text.trim().isEmpty ? 'User' : name.text.trim();
                    setState(() {
                      r.status = 'Booked';
                      r.tenantName = DummyService.userName;
                      r.tenantAddress = address.text.trim().isEmpty ? null : address.text.trim();
                      r.tenantPhone = phone.text.trim().isEmpty ? null : phone.text.trim();
                      r.rentStartDate = _dateController.text;
                    });
                    DummyService.requests.add(Request(
                      type: 'Booking Kamar',
                      date: _dateController.text,
                      note: 'Ajukan kamar ${r.code}',
                      status: 'Pending',
                      roomCode: r.code,
                      userName: DummyService.userName,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pengajuan kamar dikirim. Menunggu persetujuan admin.')),
                    );
                  },
                  child: const Text('Ajukan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userRoomInfo(Room room) {
    return Container(); // Placeholder
  }

}
