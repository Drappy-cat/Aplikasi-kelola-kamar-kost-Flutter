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
      return _availableRoomsPage();
    }
    final room = DummyService.findRoom(userRoomCode);
    if (room == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Kamar anda tidak ditemukan (mungkin dihapus admin).'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => setState(() => DummyService.userRoomCode = null),
                child: const Text('Ajukan Kamar Lagi'),
              ),
            ],
          ),
        ),
      );
    }
    return _userRoomInfo(room);
  }

  Widget _availableRoomsPage() {
    final available = DummyService.rooms.where((r) => r.status == 'Kosong').toList();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text('Kamar Tersedia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        if (available.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text('Tidak ada kamar tersedia saat ini.'))),
        ...available.map((room) => _buildRoomCard(room)),
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

  void _showRoomFacilitiesModal(BuildContext context, Room room) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fasilitas Kamar ${room.code}', style: Theme.of(context).textTheme.headlineSmall),
              const Divider(height: 24),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _buildFacilityChips(room),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildFacilityChips(Room room) {
    final chips = <Widget>[];
    if (room.wifi > 0) {
      chips.add(const Chip(label: Text('WiFi'), avatar: Icon(Icons.wifi)));
    }
    if (room.water > 0) {
      chips.add(const Chip(label: Text('Air'), avatar: Icon(Icons.water_drop_outlined)));
    }
    if (room.electricity > 0) {
      chips.add(const Chip(label: Text('Listrik'), avatar: Icon(Icons.electrical_services_outlined)));
    }
    if (room.packageFull) {
      chips.add(Chip(label: const Text('Paket Full'), avatar: const Icon(Icons.check_circle_outline), backgroundColor: Colors.green.shade100));
    }
    if (chips.isEmpty) {
      chips.add(const Chip(label: Text('Standar')));
    }
    return chips;
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
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Pengajuan',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      _dateController.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<Room>(
                value: selectedRoom,
                items: available
                    .map((r) => DropdownMenuItem(value: r, child: Text('Kamar ${r.code} • Rp ${DummyService.computeTotalForRoom(r)}')))
                    .toList(),
                onChanged: (v) => selectedRoom = v!,
                validator: (v) => v == null ? 'Pilih kamar' : null,
                decoration: const InputDecoration(labelText: 'Kamar'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: address,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: phone,
                decoration: const InputDecoration(labelText: 'No HP'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
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
    final bill = DummyService.latestBillForRoom(room.code);
    Bill? overdueBill;
    try {
      overdueBill = DummyService.bills.firstWhere((b) {
        final dueDate = DateTime.parse(b.dueDate);
        final today = DateTime.now();
        return b.roomCode == room.code && b.status == 'Belum Dibayar' && dueDate.isBefore(DateTime(today.year, today.month, today.day));
      });
    } catch (e) {
      overdueBill = null;
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (overdueBill != null)
          Card(
            color: Colors.orange.shade100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.warning, color: Colors.orange, size: 32),
                  const SizedBox(height: 8),
                  const Text('ANDA MEMILIKI TAGIHAN TERLAMBAT', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Tagihan bulan ${overdueBill.month} telah jatuh tempo pada ${overdueBill.dueDate}.'),
                  const Text('Harap segera lakukan pembayaran.'),
                ],
              ),
            ),
          ),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kamar ${room.code}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _row('Status', room.status),
                _row('Nama', room.tenantName ?? DummyService.userName ?? '–'),
                _row('Alamat', room.tenantAddress ?? '–'),
                _row('No HP', room.tenantPhone ?? '–'),
                _row('Mulai Sewa', room.rentStartDate ?? '–'),
                const Divider(),
                _row('Tagihan Terbaru', bill?.month ?? '–'),
                _row('Status Tagihan', bill?.status ?? '–'),
                const Divider(),
                const Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.family_restroom),
                      label: const Text('Kunjungan Ortu'),
                      onPressed: () => _submitSimpleRequest(
                        type: 'Kunjungan Ortu',
                        defaultNote: 'Kunjungan orang tua',
                        room: room,
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.flight_takeoff),
                      label: const Text('Pulang Kampung'),
                      onPressed: () => _submitSimpleRequest(
                        type: 'Pulang Kampung',
                        defaultNote: 'Izin pulang kampung',
                        room: room,
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('Berhenti Ngekost'),
                      onPressed: () async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (c) => AlertDialog(
                            title: const Text('Berhenti ngekost?'),
                            content: const Text(
                                'Data akan dikirim ke admin. Kamar anda akan dikosongkan.'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Batal')),
                              TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Kirim')),
                            ],
                          ),
                        ) ??
                            false;
                        if (!ok) return;

                        DummyService.requests.add(Request(
                          type: 'Berhenti',
                          date: DateTime.now().toIso8601String(),
                          note: 'Berhenti ngekost kamar ${room.code}',
                          status: 'Pending',
                          roomCode: room.code,
                          userName: DummyService.userName,
                        ));
                        setState(() {
                          room.status = 'Kosong';
                          room.tenantName = null;
                          room.tenantAddress = null;
                          room.tenantPhone = null;
                          DummyService.userRoomCode = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Permohonan berhenti dikirim.')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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

  Future<void> _submitSimpleRequest({
    required String type,
    required String defaultNote,
    required Room room,
  }) async {
    final noteCtrl = TextEditingController(text: defaultNote);
    final dateCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(type),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: dateCtrl, decoration: const InputDecoration(labelText: "Tanggal / Rentang")),
            const SizedBox(height: 8),
            TextField(controller: noteCtrl, decoration: const InputDecoration(labelText: "Catatan")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Kirim")),
        ],
      ),
    ) ??
        false;
    if (!ok) return;

    DummyService.requests.add(Request(
      type: type,
      date: dateCtrl.text.trim().isEmpty ? DateTime.now().toIso8601String() : dateCtrl.text.trim(),
      note: noteCtrl.text.trim(),
      status: "Pending",
      roomCode: room.code,
      userName: DummyService.userName,
    ));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pengajuan terkirim")),
      );
    }
  }
}
