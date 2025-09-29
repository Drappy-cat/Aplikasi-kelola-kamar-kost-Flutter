import 'package:flutter/material.dart';
import 'package:tes/shared/models/bill.dart';

class PaymentProofDetailScreen extends StatelessWidget {
  final Bill bill;

  const PaymentProofDetailScreen({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bukti Bayar - ${bill.period}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail untuk Kamar ${bill.roomId}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Jumlah: Rp ${bill.amount}'),
            Text('Metode: ${bill.paymentMethod ?? "-"}'),
            const SizedBox(height: 24),
            const Text(
              'Bukti Pembayaran:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: bill.paymentProofUrl != null
                    ? InteractiveViewer(
                        panEnabled: false, // Set it to false to prevent panning.
                        boundaryMargin: const EdgeInsets.all(100),
                        minScale: 0.5,
                        maxScale: 2,
                        child: Image.asset(bill.paymentProofUrl!),
                      )
                    : const Text('Tidak ada bukti pembayaran yang diunggah untuk transaksi ini.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
