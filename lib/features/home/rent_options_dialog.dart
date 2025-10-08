import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

class RentOptionsDialog extends StatefulWidget {
  final Room room;

  const RentOptionsDialog({super.key, required this.room});

  @override
  State<RentOptionsDialog> createState() => _RentOptionsDialogState();
}

class _RentOptionsDialogState extends State<RentOptionsDialog> {
  bool _useAc = false;
  bool _isBooking = false;
  bool _isLoading = false;

  int get _totalPrice {
    int total = widget.room.totalPrice;
    if (!_useAc) {
      total -= widget.room.acCost;
    }
    return total;
  }

  Future<void> _processRequest() async {
    setState(() => _isLoading = true);

    final authService = getIt<AuthService>();
    final dummyService = getIt<DummyService>();
    final currentUser = authService.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sesi tidak valid, silakan login ulang.')),
      );
      setState(() => _isLoading = false);
      return;
    }

    // Simulasi proses backend
    await Future.delayed(const Duration(seconds: 2));

    final roomToUpdate = dummyService.findRoom(widget.room.code);
    if (roomToUpdate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kamar tidak ditemukan.')),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_isBooking) {
      // Logika untuk Booking
      final updatedRoom = roomToUpdate.copyWith(status: 'Booked');
      await dummyService.updateRoom(updatedRoom);

      dummyService.requests.add(Request(
        id: 'req-${DateTime.now().millisecondsSinceEpoch}',
        type: 'Booking Kamar',
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        note: 'Booking kamar oleh ${currentUser.fullName}',
        status: 'Disetujui', // Booking langsung disetujui
        roomCode: widget.room.code,
        userName: currentUser.fullName,
      ));

      dummyService.notifications.add(AppNotification(
        title: 'Booking Berhasil!',
        subtitle: 'Anda berhasil melakukan booking untuk kamar ${widget.room.code}.',
        date: DateTime.now(),
        icon: Icons.bookmark_added,
        iconColor: Colors.blue,
      ));
    } else {
      // Logika untuk Sewa Langsung
      final updatedRoom = roomToUpdate.copyWith(
        status: 'Dihuni',
        tenantName: currentUser.fullName,
        rentStartDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      await dummyService.updateRoom(updatedRoom);

      // Update data user di AuthService
      authService.currentUser = currentUser.copyWith(roomId: updatedRoom.code);

      dummyService.notifications.add(AppNotification(
        title: 'Sewa Kamar Berhasil!',
        subtitle: 'Selamat! Anda sekarang adalah penghuni kamar ${widget.room.code}.',
        date: DateTime.now(),
        icon: Icons.check_circle,
        iconColor: Colors.green,
      ));
    }

    if (mounted) {
      context.pop(true); // Kirim sinyal sukses
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isBooking ? 'Booking Kamar' : 'Sewa Kamar'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Anda akan menyewa kamar ${widget.room.code}.'),
            const SizedBox(height: 16),
            if (widget.room.acCost > 0)
              SwitchListTile(
                title: const Text('Sertakan AC'),
                value: _useAc,
                onChanged: (val) => setState(() => _useAc = val),
              ),
            const Divider(),
            ListTile(
              title: const Text('Total Harga per Bulan'),
              trailing: Text(
                NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(_totalPrice),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: [_isBooking, !_isBooking],
              onPressed: (index) {
                setState(() {
                  _isBooking = index == 0;
                });
              },
              borderRadius: BorderRadius.circular(8),
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Booking')),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Sewa Langsung')),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isBooking
                  ? 'Booking akan mengamankan kamar ini untuk Anda. Pembayaran penuh diharapkan dalam 1x24 jam.'
                  : 'Sewa langsung akan menjadikan Anda penghuni kamar ini dan tagihan pertama akan segera dibuat.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(false), child: const Text('Batal')),
        _isLoading
            ? const CircularProgressIndicator()
            : FilledButton(
                onPressed: _processRequest,
                child: Text(_isBooking ? 'Booking Sekarang' : 'Sewa Sekarang'),
              ),
      ],
    );
  }
}
