import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/shared/models/bill.dart';

class QuickActionButtons extends StatelessWidget {
  final Bill? latestBill;

  const QuickActionButtons({super.key, this.latestBill});

  @override
  Widget build(BuildContext context) {
    final bool canPay = latestBill != null && latestBill!.status == 'Belum Dibayar';

    // PERBAIKAN: Mengubah layout menjadi Column untuk mengakomodasi tombol baru
    return Column(
      children: [
        // Tombol Scan Kehadiran sebagai aksi utama
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scan Kehadiran'),
            onPressed: () => context.push(AppRoutes.scanActivity),
          ),
        ),
        const SizedBox(height: 12),
        // Tombol-tombol aksi sekunder
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.payment),
                label: const Text('Bayar Tagihan'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: canPay ? Theme.of(context).colorScheme.primary : Colors.grey,
                ),
                onPressed: canPay ? () => context.push(AppRoutes.userBills) : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.report_problem_outlined),
                label: const Text('Lapor Kerusakan'),
                onPressed: () => context.push(AppRoutes.reportIssue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
