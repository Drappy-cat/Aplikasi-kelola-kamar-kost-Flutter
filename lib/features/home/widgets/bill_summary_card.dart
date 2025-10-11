import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/shared/models/bill.dart';

class BillSummaryCard extends StatelessWidget {
  final Bill? latestBill;

  const BillSummaryCard({super.key, this.latestBill});

  String _formatCurrency(num amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    if (latestBill == null) {
      return const Card(
        child: ListTile(
          leading: Icon(Icons.receipt_long_outlined),
          title: Text('Belum ada riwayat tagihan'),
        ),
      );
    }

    final Color statusColor;
    final String statusText;
    switch (latestBill!.status) {
      case 'Lunas':
        statusColor = Colors.green;
        statusText = 'Lunas';
        break;
      case 'Menunggu Konfirmasi':
        statusColor = Colors.orange;
        statusText = 'Menunggu Konfirmasi';
        break;
      default:
        statusColor = Colors.red;
        statusText = 'Belum Dibayar';
    }

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(Icons.receipt_long_outlined, color: Theme.of(context).colorScheme.primary, size: 40),
        title: Text('Tagihan ${latestBill!.period}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Total: ${_formatCurrency(latestBill!.amount)}'),
        trailing: Chip(
          label: Text(statusText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: statusColor,
        ),
        onTap: () => context.push(AppRoutes.userBills),
      ),
    );
  }
}
