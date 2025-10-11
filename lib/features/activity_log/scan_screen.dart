import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tes/features/activity_log/bloc/activity_log_bloc.dart';

// Halaman wrapper yang menyediakan BLoC
class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityLogBloc(),
      child: const ScanView(),
    );
  }
}

// Widget yang membangun UI
class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  bool _isProcessing = false;

  // Fungsi untuk menampilkan dialog konfirmasi
  Future<void> _showConfirmationDialog(BuildContext context) async {
    final bloc = context.read<ActivityLogBloc>();

    final String? action = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Aksi'),
        content: const Text('Pilih aksi yang ingin Anda catat:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop('Berangkat'),
            child: const Text('Berangkat'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop('Pulang'),
            child: const Text('Pulang'),
          ),
        ],
      ),
    );

    if (action != null) {
      bloc.add(ActivityLogEvent.add(action));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActivityLogBloc, ActivityLogState>(
      listener: (context, state) {
        // Tutup halaman scan setelah aksi berhasil atau gagal
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.successMessage!), backgroundColor: Colors.green));
          context.pop();
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!), backgroundColor: Colors.red));
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Scan QR Code Kehadiran')),
        body: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates, // Mencegah deteksi berulang
          ),
          onDetect: (capture) {
            if (_isProcessing) return; // Mencegah pemrosesan ganda

            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty) {
              final String? code = barcodes.first.rawValue;

              // Validasi QR Code
              if (code == 'RI-KOST-ATTENDANCE-SCAN-POINT') {
                setState(() {
                  _isProcessing = true;
                });
                _showConfirmationDialog(context);
              } else {
                // Jika QR code tidak valid, tampilkan pesan singkat
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('QR Code tidak valid.'), backgroundColor: Colors.orange),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
