import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _adminTab = 0;

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = AuthService.currentUser?.role == 'admin';

    if (isAdmin) {
      return _buildAdminPanel();
    } else {
      return _buildUserHomePage();
    }
  }

  // =======================================================================
  // ============================ PANEL ADMIN ============================
  // =======================================================================
  Widget _buildAdminPanel() {
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
        title: const Text('Kost - Admin Panel'),
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
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: IndexedStack(
        index: _adminTab,
        children: [
          _roomsPage(),
          _billsPage(),
          _requestsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _adminTab,
        onDestinationSelected: (i) => setState(() => _adminTab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bed_outlined), label: 'Kamar'),
          NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined), label: 'Tagihan'),
          NavigationDestination(
              icon: Icon(Icons.inbox_outlined), label: 'Pengajuan'),
        ],
      ),
    );
  }

  Widget _roomsPage() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: DummyService.rooms.length,
      itemBuilder: (context, index) {
        final room = DummyService.rooms[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text('Kamar ${room.code}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${room.status}'),
                if (room.tenantName != null) Text('Penghuni: ${room.tenantName}'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showRoomDetails(room),
          ),
        );
      },
    );
  }

  void _showRoomDetails(Room room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter modalState) {
                return SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Detail Kamar ${room.code}', style: Theme.of(context).textTheme.headlineSmall),
                      const Divider(),
                      _buildDetailRow('Status', room.status),
                      _buildDetailRow('Sewa Dasar', 'Rp ${room.baseRent}'),
                      _buildDetailRow('WiFi', 'Rp ${room.wifi}'),
                      _buildDetailRow('Air', 'Rp ${room.water}'),
                      _buildDetailRow('Listrik', 'Rp ${room.electricity}'),
                      _buildDetailRow('Paket Full', room.packageFull ? 'Ya' : 'Tidak'),
                      const Divider(),
                      if (room.tenantName != null) ...[
                        _buildDetailRow('Nama Penghuni', room.tenantName!),
                        _buildDetailRow('Alamat', room.tenantAddress ?? '-'),
                        _buildDetailRow('No. HP', room.tenantPhone ?? '-'),
                      ],
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.icon(
                            icon: const Icon(Icons.receipt_long),
                            label: const Text('Buat Tagihan'),
                            onPressed: () {
                              Navigator.pop(context);
                              _showCreateBillDialog(room);
                            },
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.person_remove_outlined),
                            label: const Text('Kosongkan Hunian'),
                            onPressed: room.status != 'Dihuni'
                                ? null
                                : () {
                                    setState(() {
                                      room.status = 'Kosong';
                                      room.tenantName = null;
                                      room.tenantAddress = null;
                                      room.tenantPhone = null;
                                    });
                                    Navigator.pop(context);
                                  },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _billsPage() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: DummyService.bills.length,
      itemBuilder: (context, index) {
        final bill = DummyService.bills[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text('Tagihan ${bill.roomCode} - ${bill.month}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total: Rp ${bill.total}'),
                Text('Status: ${bill.status}'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showBillDetails(bill),
          ),
        );
      },
    );
  }

  void _showBillDetails(Bill bill) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detail Tagihan ${bill.roomCode}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Bulan', bill.month),
              _buildDetailRow('Total', 'Rp ${bill.total}'),
              _buildDetailRow('Status', bill.status),
              if (bill.method != null) _buildDetailRow('Metode', bill.method!),
              if (bill.channel != null) _buildDetailRow('Channel', bill.channel!),
            ],
          ),
          actions: [
            if (bill.status == 'Belum Dibayar')
              TextButton(
                onPressed: () {
                  setState(() {
                    bill.status = 'Lunas';
                  });
                  Navigator.pop(context);
                },
                child: const Text('Tandai Lunas'),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showCreateBillDialog(Room r) {
    final monthController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Buat Tagihan untuk ${r.code}'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: monthController,
                  decoration: const InputDecoration(labelText: 'Label Bulan (cth: Oktober 2025)'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final monthLabel = monthController.text;
                  final now = DateTime.now();
                  final dueDate = DateTime(now.year, now.month, 10);
                  final formattedDueDate = DateFormat('yyyy-MM-dd').format(dueDate);

                  setState(() {
                    DummyService.generateBillForRoom(r, monthLabel, formattedDueDate);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Buat'),
            ),
          ],
        );
      },
    );
  }

  Widget _requestsPage() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: DummyService.requests.length,
      itemBuilder: (context, index) {
        final req = DummyService.requests[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(req.type, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                _row("User", req.userName ?? '-'),
                _row("Kamar", req.roomCode ?? '-'),
                _row("Tanggal", req.date),
                _row("Catatan", req.note),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("Status: ", style: TextStyle(color: Colors.black54)),
                    Chip(
                      label: Text(req.status),
                      backgroundColor: req.status == 'Pending'
                          ? Colors.orange.shade100
                          : req.status == 'Disetujui'
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (req.status == 'Pending')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            req.status = 'Ditolak';
                          });
                        },
                        child: const Text("Tolak", style: TextStyle(color: Colors.red)),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            req.status = 'Disetujui';
                          });
                        },
                        child: const Text("Setujui"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =======================================================================
  // ============================ HALAMAN USER =============================
  // =======================================================================
  Widget _buildUserHomePage() {
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
              // TODO: Navigasi ke halaman settings
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
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
              const Text("Kamar anda tidak ditemukan (mungkin dihapus admin)."),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => setState(() => DummyService.userRoomCode = null),
                child: const Text("Ajukan Kamar Lagi"),
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
          child: Text("Kamar Tersedia", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        if (available.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(16.0), child: Text("Tidak ada kamar tersedia saat ini."))),
        ...available.map((room) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text("Kamar ${room.code}"),
            subtitle: Text("Rp ${DummyService.computeTotalForRoom(room)} / bulan"),
            trailing: const Icon(Icons.chevron_right),
          ),
        )),
        const SizedBox(height: 24),
        _bookingForm(),
      ],
    );
  }

  Widget _bookingForm() {
    final formKey = GlobalKey<FormState>();
    Room? selectedRoom;
    final name = TextEditingController(text: AuthService.currentUser?.fullName ?? '');
    final address = TextEditingController();
    final phone = TextEditingController();
    final submissionDate = DateTime.now();
    final dateString = DateFormat('yyyy-MM-dd').format(submissionDate);

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
              const Text("Ajukan Kamar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: dateString,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Tanggal Pengajuan", prefixIcon: Icon(Icons.calendar_today)),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<Room>(
                value: selectedRoom,
                items: available
                    .map((r) => DropdownMenuItem(value: r, child: Text("${r.code} • Rp ${DummyService.computeTotalForRoom(r)}")))
                    .toList(),
                onChanged: (v) => selectedRoom = v!,
                validator: (v) => v == null ? "Pilih kamar" : null,
                decoration: const InputDecoration(labelText: "Kamar"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: "Nama Lengkap"),
                validator: (v) => (v == null || v.isEmpty) ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: address,
                decoration: const InputDecoration(labelText: "Alamat"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: phone,
                decoration: const InputDecoration(labelText: "No HP"),
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
                    DummyService.userName = name.text.trim().isEmpty ? "User" : name.text.trim();
                    setState(() {
                      r.status = "Booked";
                      r.tenantName = DummyService.userName;
                      r.tenantAddress = address.text.trim().isEmpty ? null : address.text.trim();
                      r.tenantPhone = phone.text.trim().isEmpty ? null : phone.text.trim();
                      r.rentStartDate = dateString;
                    });
                    DummyService.requests.add(Request(
                      type: "Booking Kamar",
                      date: dateString,
                      note: "Ajukan kamar ${r.code}",
                      status: "Pending",
                      roomCode: r.code,
                      userName: DummyService.userName,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pengajuan kamar dikirim. Menunggu persetujuan admin.")),
                    );
                  },
                  child: const Text("Ajukan"),
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
                  const Text("ANDA MEMILIKI TAGIHAN TERLAMBAT", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Tagihan bulan ${overdueBill.month} telah jatuh tempo pada ${overdueBill.dueDate}."),
                  const Text("Harap segera lakukan pembayaran."),
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
                Text("Kamar ${room.code}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _row("Status", room.status),
                _row("Nama", room.tenantName ?? DummyService.userName ?? '–'),
                _row("Alamat", room.tenantAddress ?? '–'),
                _row("No HP", room.tenantPhone ?? '–'),
                _row("Mulai Sewa", room.rentStartDate ?? '–'),
                const Divider(),
                _row("Tagihan Terbaru", bill?.month ?? "-"),
                _row("Status Tagihan", bill?.status ?? "-"),
                const Divider(),
                const Text("Aksi", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.family_restroom),
                      label: const Text("Kunjungan Ortu"),
                      onPressed: () => _submitSimpleRequest(
                        type: "Kunjungan Ortu",
                        defaultNote: "Kunjungan orang tua",
                        room: room,
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.flight_takeoff),
                      label: const Text("Pulang Kampung"),
                      onPressed: () => _submitSimpleRequest(
                        type: "Pulang Kampung",
                        defaultNote: "Izin pulang kampung",
                        room: room,
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text("Berhenti Ngekost"),
                      onPressed: () async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (c) => AlertDialog(
                            title: const Text("Berhenti ngekost?"),
                            content: const Text(
                                "Data akan dikirim ke admin. Kamar anda akan dikosongkan."),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
                              TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Kirim")),
                            ],
                          ),
                        ) ??
                            false;
                        if (!ok) return;

                        DummyService.requests.add(Request(
                          type: "Berhenti",
                          date: DateTime.now().toIso8601String(),
                          note: "Berhenti ngekost kamar ${room.code}",
                          status: "Pending",
                          roomCode: room.code,
                          userName: DummyService.userName,
                        ));
                        setState(() {
                          room.status = "Kosong";
                          room.tenantName = null;
                          room.tenantAddress = null;
                          room.tenantPhone = null;
                          DummyService.userRoomCode = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Permohonan berhenti dikirim.")),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: const TextStyle(color: Colors.grey)), Text(value)],
      ),
    );
  }
}
