import 'package:flutter/material.dart';
import 'models/bill.dart';
import 'models/request.dart';
import 'models/room.dart';
import 'services/dummy_service.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _dashboardPage(),
      _billsPage(),
      _requestsPage(),
      _profilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kost Manager"),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: "Toggle Dark/Light",
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: _showAddRoomDialog,
        child: const Icon(Icons.add_home),
      )
          : _selectedIndex == 2
          ? FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: _showAddRequestDialog,
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Tagihan"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Pengajuan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  // ------------------ DASHBOARD (LIST KAMAR) ------------------
  Widget _dashboardPage() {
    final unpaid =
        DummyService.bills.where((b) => b.status == "Belum Dibayar").length;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(.25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.pink),
              title: const Text("Tagihan Bulan Ini"),
              subtitle: Text("Belum Dibayar: $unpaid"),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: DummyService.rooms.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final room = DummyService.rooms[i];
                return Dismissible(
                  key: ValueKey(room.code),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text("Hapus Kamar?"),
                        content: Text("Yakin hapus kamar ${room.code}?"),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
                          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Hapus")),
                        ],
                      ),
                    ) ??
                        false;
                  },
                  onDismissed: (_) {
                    setState(() => DummyService.rooms.removeAt(i));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Kamar ${room.code} dihapus")),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(Icons.home, color: _statusColor(room.status)),
                      title: Text("Kamar ${room.code}"),
                      subtitle: Text("Status: ${room.status}"),
                      onTap: () => _showRoomDetail(room),
                      trailing: room.status == "Dihuni"
                          ? IconButton(
                        tooltip: "Kosongkan hunian",
                        icon: const Icon(Icons.person_remove, color: Colors.pink),
                        onPressed: () => _vacateRoom(room),
                      )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Dihuni':
        return Colors.green;
      case 'Kosong':
        return Colors.grey;
      case 'Booked':
        return Colors.orange;
      case 'Maintenance':
        return Colors.red;
      default:
        return Colors.pink;
    }
  }

  // ---------- Kosongkan hunian ----------
  Future<void> _vacateRoom(Room room) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Kosongkan Hunian"),
        content: Text(
            "Kamar ${room.code} berstatus \"${room.status}\".\n"
                "Hapus data penghuni dan ubah status menjadi \"Kosong\"?"
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Kosongkan")),
        ],
      ),
    ) ??
        false;

    if (!ok) return;

    setState(() {
      room.status = "Kosong";
      room.tenantName = null;
      room.tenantAddress = null;
      room.tenantPhone = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Kamar ${room.code} dikosongkan")),
    );
  }

  // ---------- Tambah kamar + auto-generate bill ----------
  void _showAddRoomDialog() {
    final formKey = GlobalKey<FormState>();
    final code = TextEditingController();
    final rent = TextEditingController();
    final wifi = TextEditingController(text: "100000");
    final water = TextEditingController(text: "50000");
    final elec = TextEditingController(text: "150000");
    final tenant = TextEditingController();
    final addr = TextEditingController();
    final phone = TextEditingController();
    String status = "Kosong";
    bool fullPack = false;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Tambah Kamar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: code,
                    decoration: const InputDecoration(labelText: "Kode Kamar (mis. A-103)"),
                    validator: (v) => (v == null || v.isEmpty) ? "Wajib diisi" : null,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: status,
                    decoration: const InputDecoration(labelText: "Status"),
                    items: const [
                      DropdownMenuItem(value: "Kosong", child: Text("Kosong")),
                      DropdownMenuItem(value: "Dihuni", child: Text("Dihuni")),
                      DropdownMenuItem(value: "Booked", child: Text("Booked")),
                      DropdownMenuItem(value: "Maintenance", child: Text("Maintenance")),
                    ],
                    onChanged: (v) => status = v!,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: rent,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Sewa Kamar / bulan (Rp)"),
                    validator: (v) => (v == null || v.isEmpty) ? "Wajib diisi" : null,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Paket Lengkap (Wifi + Air + Listrik termasuk)"),
                    value: fullPack,
                    onChanged: (val) => setState(() => fullPack = val),
                  ),
                  if (!fullPack) ...[
                    TextFormField(
                      controller: wifi,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Biaya Wifi (Rp)"),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: water,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Biaya Air (Rp)"),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: elec,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Biaya Listrik (Rp)"),
                    ),
                  ],
                  const Divider(height: 24),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: const Text("Data Penghuni (opsional)"),
                    children: [
                      TextFormField(controller: tenant, decoration: const InputDecoration(labelText: "Nama Penghuni")),
                      const SizedBox(height: 8),
                      TextFormField(controller: addr, decoration: const InputDecoration(labelText: "Alamat Penghuni")),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(labelText: "No HP Penghuni"),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          final r = Room(
                            code: code.text.trim(),
                            status: status,
                            baseRent: int.tryParse(rent.text.trim()) ?? 0,
                            wifi: fullPack ? 0 : int.tryParse(wifi.text.trim()) ?? 0,
                            water: fullPack ? 0 : int.tryParse(water.text.trim()) ?? 0,
                            electricity: fullPack ? 0 : int.tryParse(elec.text.trim()) ?? 0,
                            packageFull: fullPack,
                            tenantName: tenant.text.trim().isEmpty ? null : tenant.text.trim(),
                            tenantAddress: addr.text.trim().isEmpty ? null : addr.text.trim(),
                            tenantPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
                          );
                          setState(() {
                            DummyService.rooms.add(r);
                            final now = DateTime.now();
                            final monthLabel = _monthName(now.month) + " ${now.year}";
                            DummyService.generateBillForRoom(r, monthLabel);
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Kamar ${r.code} ditambahkan & tagihan dibuat")),
                          );
                        },
                        child: const Text("Simpan"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _monthName(int m) {
    const names = [
      "", "Januari","Februari","Maret","April","Mei","Juni",
      "Juli","Agustus","September","Oktober","November","Desember"
    ];
    return names[m];
  }

  // ------------------ DETAIL KAMAR + BAYAR ------------------
  void _showRoomDetail(Room room) {
    final bill = DummyService.latestBillForRoom(room.code);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Detail ${room.code}",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(Icons.info, "Status", room.status),
                  const Divider(),
                  if (room.tenantName != null) ...[
                    _buildDetailRow(Icons.person, "Penghuni", room.tenantName!),
                    _buildDetailRow(Icons.home, "Alamat", room.tenantAddress ?? "-"),
                    _buildDetailRow(Icons.phone, "No HP", room.tenantPhone ?? "-"),
                    const Divider(),
                  ],
                  if (bill != null) ...[
                    _buildDetailRow(Icons.calendar_today, "Tagihan Terbaru", bill.month),
                    _buildDetailRow(Icons.receipt, "Status Tagihan", bill.status),
                  ] else
                    const Text("Belum ada tagihan."),
                  const Divider(),
                  const Text("Detail Biaya", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  _buildDetailRow(Icons.bed, "Sewa Kamar", "Rp ${room.baseRent}"),
                  if (room.packageFull)
                    _buildDetailRow(Icons.check_circle, "Paket Lengkap", "Termasuk Wifi, Air, Listrik")
                  else ...[
                    _buildDetailRow(Icons.wifi, "Wifi", "Rp ${room.wifi}"),
                    _buildDetailRow(Icons.water, "Air", "Rp ${room.water}"),
                    _buildDetailRow(Icons.bolt, "Listrik", "Rp ${room.electricity}"),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (bill != null && bill.status != "Lunas")
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showPayDialog(bill);
                          },
                          icon: const Icon(Icons.payment),
                          label: const Text("Bayar Tagihan"),
                        ),
                      const SizedBox(width: 8),
                      if (room.status == "Dihuni") ...[
                        OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _vacateRoom(room);
                          },
                          icon: const Icon(Icons.person_remove),
                          label: const Text("Kosongkan"),
                        ),
                        const SizedBox(width: 8),
                      ],
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Tutup"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.pink, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------ TAGIHAN (klik untuk bayar) ------------------
  Widget _billsPage() {
    return ListView.builder(
      itemCount: DummyService.bills.length,
      itemBuilder: (context, index) {
        final Bill bill = DummyService.bills[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.receipt),
            title: Text("${bill.month} • ${bill.roomCode}"),
            subtitle: Text("Total: Rp ${bill.total}"),
            trailing: Text(
              bill.status,
              style: TextStyle(
                color: bill.status == "Lunas" ? Colors.green : Colors.red,
              ),
            ),
            onTap: () => _showPayDialog(bill),
          ),
        );
      },
    );
  }

  // ---------- Dialog pembayaran ----------
  void _showPayDialog(Bill bill) {
    String method = bill.method ?? "Cash";
    String channel = bill.channel ?? "QRIS";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Bayar Tagihan"),
        content: StatefulBuilder(
          builder: (context, setS) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${bill.roomCode} • ${bill.month}"),
                const SizedBox(height: 6),
                Text("Total: Rp ${bill.total}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Divider(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Metode", style: Theme.of(context).textTheme.titleSmall),
                ),
                RadioListTile<String>(
                  value: "Cash",
                  groupValue: method,
                  onChanged: (v) => setS(() => method = v!),
                  title: const Text("Cash"),
                  dense: true,
                ),
                RadioListTile<String>(
                  value: "Transfer",
                  groupValue: method,
                  onChanged: (v) => setS(() => method = v!),
                  title: const Text("Transfer"),
                  dense: true,
                ),
                if (method == "Transfer") ...[
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Channel", style: Theme.of(context).textTheme.titleSmall),
                  ),
                  RadioListTile<String>(
                    value: "QRIS",
                    groupValue: channel,
                    onChanged: (v) => setS(() => channel = v!),
                    title: const Text("QRIS"),
                    dense: true,
                  ),
                  RadioListTile<String>(
                    value: "Bank Transfer",
                    groupValue: channel,
                    onChanged: (v) => setS(() => channel = v!),
                    title: const Text("Bank Transfer"),
                    dense: true,
                  ),
                ],
              ],
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            onPressed: () {
              setState(() {
                bill.status = "Lunas";
                bill.method = method;
                bill.channel = method == "Transfer" ? channel : null;
              });
              Navigator.pop(context);

              final detailChannel =
              (bill.method == "Transfer" && bill.channel != null) ? " - ${bill.channel}" : "";
              final msg =
                  "Tagihan ${bill.roomCode} • ${bill.month} dibayar (${bill.method}$detailChannel)";
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            },
            child: const Text("Konfirmasi"),
          ),
        ],
      ),
    );
  }

  // ------------------ PENGAJUAN ------------------
  Widget _requestsPage() {
    return ListView.builder(
      itemCount: DummyService.requests.length,
      itemBuilder: (context, index) {
        final Request req = DummyService.requests[index];
        return Card(
          child: ListTile(
            leading: Icon(
              req.type == "Kunjungan Ortu" ? Icons.family_restroom : Icons.flight_takeoff,
              color: Colors.pink,
            ),
            title: Text(req.type),
            subtitle: Text("${req.date}\n${req.note}"),
            trailing: Text(
              req.status,
              style: TextStyle(
                color: req.status == "Disetujui"
                    ? Colors.green
                    : req.status == "Pending"
                    ? Colors.orange
                    : Colors.red,
              ),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  void _showAddRequestDialog() {
    final formKey = GlobalKey<FormState>();
    String type = "Kunjungan Ortu";
    String date = "";
    String note = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Pengajuan"),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: type,
                    items: const [
                      DropdownMenuItem(value: "Kunjungan Ortu", child: Text("Kunjungan Ortu")),
                      DropdownMenuItem(value: "Pulang Kampung", child: Text("Pulang Kampung")),
                    ],
                    onChanged: (val) => type = val!,
                    decoration: const InputDecoration(labelText: "Jenis Pengajuan"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Tanggal / Rentang"),
                    validator: (v) => v == null || v.isEmpty ? "Wajib diisi" : null,
                    onSaved: (v) => date = v!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Catatan"),
                    onSaved: (v) => note = v ?? "",
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                formKey.currentState!.save();
                setState(() {
                  DummyService.requests.add(Request(
                    type: type,
                    date: date,
                    note: note,
                    status: "Pending",
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  // ------------------ PROFIL ------------------
  Widget _profilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.pink,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text("User Dummy", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
          ),
        ],
      ),
    );
  }
}
