import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/app_notification.dart'; // Import model notifikasi
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

class RentOptionsDialog extends StatefulWidget {
  final Room room;

  const RentOptionsDialog({super.key, required this.room});

  @override
  State<RentOptionsDialog> createState() => _RentOptionsDialogState();
}

class _RentOptionsDialogState extends State<RentOptionsDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;

  bool _isPackageFull = true;
  bool _hasAc = false;

  @override
  void initState() {
    super.initState();
    _isPackageFull = widget.room.packageFull;
    final currentUser = AuthService.currentUser;
    _nameController = TextEditingController(text: currentUser?.fullName ?? currentUser?.username ?? '');
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalRent = widget.room.baseRent;
    int wifiCost = _isPackageFull ? 0 : widget.room.wifi;
    int waterCost = _isPackageFull ? 0 : widget.room.water;
    int electricityCost = _isPackageFull ? 0 : widget.room.electricity;
    int acCost = _hasAc ? widget.room.acCost : 0;
    totalRent += wifiCost + waterCost + electricityCost + acCost;

    return AlertDialog(
      title: Text('Sewa Kamar ${widget.room.code}'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Data Calon Penyewa:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Alamat Asal'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Alamat wajib diisi' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'No. Telepon Aktif'),
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.isEmpty) ? 'No. Telepon wajib diisi' : null,
                ),
                const Divider(height: 24),

                const Text('Pilih Paket Sewa:', style: TextStyle(fontWeight: FontWeight.bold)),
                RadioListTile<bool>(
                  title: const Text('Paket Lengkap'),
                  subtitle: const Text('WiFi, Air, & Listrik sudah termasuk'),
                  value: true,
                  groupValue: _isPackageFull,
                  onChanged: (value) => setState(() => _isPackageFull = value!),
                ),
                RadioListTile<bool>(
                  title: const Text('Bayar Mandiri'),
                  subtitle: const Text('Bayar utilitas secara terpisah'),
                  value: false,
                  groupValue: _isPackageFull,
                  onChanged: (value) => setState(() => _isPackageFull = value!),
                ),
                const Divider(),
                CheckboxListTile(
                  title: const Text('Tambah AC'),
                  subtitle: Text('Biaya tambahan: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(widget.room.acCost)}'),
                  value: _hasAc,
                  onChanged: (value) => setState(() => _hasAc = value!),
                ),
                const Divider(height: 24),

                const Text('Rincian Biaya:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildCostRow('Sewa Dasar', widget.room.baseRent),
                _buildCostRow('WiFi (10 Mbps)', wifiCost),
                _buildCostRow('Air', waterCost),
                _buildCostRow('Listrik', electricityCost),
                _buildCostRow('AC', acCost),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total per Bulan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(totalRent),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            final user = AuthService.currentUser;
            if (user == null) return;

            final room = widget.room;
            room.status = 'Booked';
            room.tenantName = _nameController.text.trim();
            room.tenantAddress = _addressController.text.trim();
            room.tenantPhone = _phoneController.text.trim();
            room.rentStartDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
            room.packageFull = _isPackageFull;

            DummyService.requests.add(Request(
              type: 'Booking Kamar',
              date: room.rentStartDate!,
              note: 'Pengajuan sewa untuk kamar ${room.code} oleh ${_nameController.text.trim()}',
              status: 'Pending',
              roomCode: room.code,
              userName: user.username,
            ));

            // --- MENAMBAHKAN NOTIFIKASI PENGajuan SEWA ---
            DummyService.notifications.add(AppNotification(
              title: 'Pengajuan Sewa Kamar ${room.code}',
              subtitle: 'Pengajuan Anda sedang menunggu konfirmasi admin.',
              date: DateTime.now(),
              icon: Icons.hourglass_empty,
              iconColor: Colors.orange,
            ));

            DummyService.userRoomCode = room.code;
            DummyService.updateRoom(room);

            Navigator.pop(context, true);
          },
          child: const Text('Ajukan Sewa'),
        ),
      ],
    );
  }

  Widget _buildCostRow(String label, int cost) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(currencyFormatter.format(cost)),
        ],
      ),
    );
  }
}
