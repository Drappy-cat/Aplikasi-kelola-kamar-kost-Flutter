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

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.payment),
            label: const Text('Bayar Tagihan'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: canPay ? Theme.of(context).colorScheme.primary : Colors.grey,
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
    );
  }
}
