import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

// Enum untuk merepresentasikan setiap langkah dalam dialog
enum DialogStep { initial, paymentMethod, paymentTransferOptions, virtualAccount, qrCode }

class RentOptionsDialog extends StatefulWidget {
  final Room room;

  const RentOptionsDialog({super.key, required this.room});

  @override
  State<RentOptionsDialog> createState() => _RentOptionsDialogState();
}

class _RentOptionsDialogState extends State<RentOptionsDialog> {
  // State untuk alur dialog
  DialogStep _currentStep = DialogStep.initial;

  // State untuk data
  bool _useAc = false;
  bool _isBooking = false;
  DateTime _selectedBookingDate = DateTime.now();
  bool _isLoading = false;

  // State untuk pembayaran VA
  String _virtualAccountNumber = '';
  Timer? _countdownTimer;
  Duration _timerDuration = const Duration(hours: 1);

  // Service instances
  final AuthService _authService = getIt<AuthService>();
  final DummyService _dummyService = getIt<DummyService>();

  @override
  void initState() {
    super.initState();
    _useAc = widget.room.acCost > 0;
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  // --- GETTERS ---
  int get _totalPrice {
    int total = widget.room.baseRent + widget.room.wifi + widget.room.water + widget.room.electricity;
    if (_useAc) {
      total += widget.room.acCost;
    }
    return total;
  }

  // --- NAVIGASI & LOGIKA ALUR ---
  void _goToStep(DialogStep step) {
    setState(() {
      _currentStep = step;
    });
  }

  Future<void> _startVirtualAccountPayment() async {
    setState(() => _isLoading = true);

    final vaNumber = '8808${Random().nextInt(999999999).toString().padLeft(9, '0')}';
    final dueDate = DateTime.now().add(const Duration(hours: 1));

    await _dummyService.addRequest(
      type: _isBooking ? 'Booking via VA' : 'Sewa via VA',
      note: 'Menunggu pembayaran VA untuk kamar ${widget.room.code}',
      status: 'Menunggu Pembayaran',
      roomCode: widget.room.code,
      paymentMethod: 'Virtual Account',
      virtualAccountNumber: vaNumber,
      paymentDueDate: dueDate,
    );

    setState(() {
      _currentStep = DialogStep.virtualAccount;
      _virtualAccountNumber = vaNumber;
      _timerDuration = dueDate.difference(DateTime.now());
      _isLoading = false;
    });
    _startTimer();
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDuration.inSeconds <= 0) {
        timer.cancel();
        if (mounted) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Waktu pembayaran habis.'), backgroundColor: Colors.orange),
          );
        }
      } else {
        setState(() {
          _timerDuration = _timerDuration - const Duration(seconds: 1);
        });
      }
    });
  }

  // --- BUILDERS UNTUK SETIAP LANGKAH ---
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCurrentStepWidget(context),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _buildCurrentStepWidget(BuildContext context) {
    switch (_currentStep) {
      case DialogStep.initial:
        return _buildInitialStep(context);
      case DialogStep.paymentMethod:
        return _buildPaymentMethodStep(context);
      case DialogStep.paymentTransferOptions:
        return _buildTransferOptionsStep(context);
      case DialogStep.virtualAccount:
        return _buildVirtualAccountStep(context);
      case DialogStep.qrCode:
        return _buildQrCodeStep(context);
    }
  }

  // --- LANGKAH 1: PILIHAN AWAL (BOOKING/SEWA) ---
  Widget _buildInitialStep(BuildContext context) {
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
              onPressed: (index) => setState(() => _isBooking = index == 0),
              borderRadius: BorderRadius.circular(8),
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Booking')),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Sewa Langsung')),
              ],
            ),
            if (_isBooking)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Tanggal Mulai Booking'),
                  subtitle: Text(DateFormat.yMMMd().format(_selectedBookingDate)),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedBookingDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                    );
                    if (picked != null && picked != _selectedBookingDate) {
                      setState(() => _selectedBookingDate = picked);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(false), child: const Text('Batal')),
        FilledButton(
          onPressed: () => _goToStep(DialogStep.paymentMethod),
          child: const Text('Lanjutkan'),
        ),
      ],
    );
  }

  // --- LANGKAH 2: PILIHAN METODE PEMBAYARAN ---
  Widget _buildPaymentMethodStep(BuildContext context) {
    return AlertDialog(
      title: const Text('Pilih Metode Pembayaran'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.money),
            title: const Text('Bayar Tunai'),
            subtitle: const Text('Konfirmasi manual oleh admin'),
            onTap: () async {
              await _processCashRequest();
              if (mounted) context.pop(true);
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Transfer Bank / QRIS'),
            subtitle: const Text('Pembayaran otomatis'),
            onTap: () => _goToStep(DialogStep.paymentTransferOptions),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => _goToStep(DialogStep.initial), child: const Text('Kembali')),
      ],
    );
  }

  // --- LANGKAH 2.5: PILIHAN TRANSFER (VA/QRIS) ---
  Widget _buildTransferOptionsStep(BuildContext context) {
    return AlertDialog(
      title: const Text('Pilih Jenis Transfer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.qr_code_2),
            title: const Text('Pembayaran QRIS'),
            onTap: () => _goToStep(DialogStep.qrCode),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Virtual Account'),
            onTap: () => _startVirtualAccountPayment(),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => _goToStep(DialogStep.paymentMethod), child: const Text('Kembali')),
      ],
    );
  }

  // --- LANGKAH 3: PEMBAYARAN VIRTUAL ACCOUNT ---
  Widget _buildVirtualAccountStep(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(_timerDuration.inMinutes.remainder(60));
    final seconds = twoDigits(_timerDuration.inSeconds.remainder(60));

    return AlertDialog(
      title: const Text('Selesaikan Pembayaran'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Segera selesaikan pembayaran Anda dalam:'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('$minutes:$seconds', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.red)),
          ),
          const Text('Nomor Virtual Account:'),
          const SizedBox(height: 8),
          SelectableText(
            _virtualAccountNumber,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            icon: const Icon(Icons.copy, size: 16),
            label: const Text('Salin Nomor'),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _virtualAccountNumber));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nomor VA disalin!')));
            },
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => context.pop(false), child: const Text('Batalkan')),
        FilledButton(
          onPressed: () async {
            await _processAutomaticApprovalRequest('Virtual Account');
            if (mounted) context.pop(true);
          },
          child: const Text('Saya Sudah Bayar'),
        ),
      ],
    );
  }

  // --- LANGKAH 4: PEMBAYARAN QRIS ---
  Widget _buildQrCodeStep(BuildContext context) {
    return AlertDialog(
      title: const Text('Pindai Kode QRIS'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Gunakan aplikasi perbankan Anda untuk memindai kode di bawah ini.'),
          const SizedBox(height: 16),
          // Menggunakan path aset yang baru
          Image.asset('assets/qr_scan/qr.png', height: 200, width: 200),
          const SizedBox(height: 16),
          Text('Total: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(_totalPrice)}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        TextButton(onPressed: () => _goToStep(DialogStep.paymentTransferOptions), child: const Text('Kembali')),
        FilledButton(
          onPressed: () async {
            await _processAutomaticApprovalRequest('QRIS');
            if (mounted) context.pop(true);
          },
          child: const Text('Saya Sudah Bayar'),
        ),
      ],
    );
  }

  // --- LOGIKA PROSES BACKEND ---
  Future<void> _processCashRequest() async {
    setState(() => _isLoading = true);
    await _dummyService.addRequest(
      type: _isBooking ? 'Booking Tunai' : 'Sewa Tunai',
      note: 'Menunggu persetujuan pembayaran tunai untuk kamar ${widget.room.code}',
      status: 'Menunggu Persetujuan',
      roomCode: widget.room.code,
      paymentMethod: 'Tunai',
    );
    setState(() => _isLoading = false);
  }

  Future<void> _processAutomaticApprovalRequest(String paymentMethod) async {
    setState(() => _isLoading = true);
    final currentUser = _authService.currentUser!;
    final roomToUpdate = _dummyService.findRoom(widget.room.code)!;

    if (_isBooking) {
      final updatedRoom = roomToUpdate.copyWith(status: 'Booked');
      await _dummyService.updateRoom(updatedRoom);
      await _dummyService.addRequest(
        type: 'Booking via $paymentMethod',
        note: 'Booking kamar oleh ${currentUser.fullName} untuk tanggal ${DateFormat.yMMMd().format(_selectedBookingDate)}',
        status: 'Disetujui',
        roomCode: widget.room.code,
        paymentMethod: paymentMethod,
      );
    } else {
      final updatedRoom = roomToUpdate.copyWith(
        status: 'Dihuni',
        tenantName: currentUser.fullName,
        rentStartDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      await _dummyService.updateRoom(updatedRoom);
      _authService.currentUser = currentUser.copyWith(roomId: updatedRoom.code);
    }
    setState(() => _isLoading = false);
  }
}
