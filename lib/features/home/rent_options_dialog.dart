
import 'package:flutter/material.dart';
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
  bool _isPackageFull = true;
  bool _hasAc = false;

  @override
  void initState() {
    super.initState();
    _isPackageFull = widget.room.packageFull;
  }

  @override
  Widget build(BuildContext context) {
    int electricityWatt = 450;
    if (_isPackageFull) {
      electricityWatt = 900;
    }
    if (_hasAc) {
      electricityWatt = 1200;
    }

    int totalRent = widget.room.baseRent;
    int waterCost = 0;
    int electricityCost = 0;
    int wifiCost = 0;
    int acCost = 0;

    if (!_isPackageFull) {
      wifiCost = widget.room.wifi;
      waterCost = widget.room.water;
      electricityCost = widget.room.electricity;
      totalRent += wifiCost + waterCost + electricityCost;
    }

    if (_hasAc) {
      acCost = widget.room.acCost;
      totalRent += acCost;
    }

    return AlertDialog(
      title: Text('Sewa Kamar ${widget.room.code}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Paket Sewa:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<bool>(
              title: const Text('Paket Lengkap'),
              subtitle: const Text('WiFi, Air, & Listrik gratis'),
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
              subtitle: Text('Biaya tambahan Rp ${widget.room.acCost}'),
              value: _hasAc,
              onChanged: (value) => setState(() => _hasAc = value!),
            ),
            const Divider(),
            const Text('Rincian Biaya:', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildCostRow('Sewa Dasar', widget.room.baseRent),
            _buildCostRow('WiFi (10 Mbps)', _isPackageFull ? 0 : wifiCost),
            _buildCostRow('Air', _isPackageFull ? 0 : waterCost),
            _buildCostRow('Listrik ($electricityWatt watt)', _isPackageFull ? 0 : electricityCost),
            _buildCostRow('AC', _hasAc ? acCost : 0),
            const Divider(),
            _buildCostRow('Total per Bulan', totalRent, isTotal: true),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            final user = AuthService.currentUser;
            if (user == null) {
              Navigator.pop(context, false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Anda harus login untuk menyewa.')),
              );
              return;
            }

            final roomIndex = DummyService.rooms.indexWhere((r) => r.code == widget.room.code);
            if (roomIndex != -1) {
              final room = DummyService.rooms[roomIndex];
              room.status = 'Isi';
              room.tenantName = user.fullName ?? user.username;
              room.packageFull = _isPackageFull;
              DummyService.userRoomCode = room.code;
              Navigator.pop(context, true); // Return true on success
            } else {
              Navigator.pop(context, false);
            }
          },
          child: const Text('Sewa'),
        ),
      ],
    );
  }

  Widget _buildCostRow(String label, int cost, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            'Rp $cost',
            style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
