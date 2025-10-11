import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/shared/models/bill.dart';

class BillsPage extends StatelessWidget {
  final List<Bill> pendingBills;
  const BillsPage({super.key, required this.pendingBills});

  @override
  Widget build(BuildContext context) {
    if (pendingBills.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada tagihan yang menunggu konfirmasi.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: pendingBills.length,
      itemBuilder: (context, index) {
        final bill = pendingBills[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Konfirmasi untuk Kamar ${bill.roomId}'),
            subtitle: Text('Periode: ${bill.period}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showConfirmationDetails(context, bill),
          ),
        );
      },
    );
  }

  void _showConfirmationDetails(BuildContext context, Bill bill) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Detail Konfirmasi - ${bill.roomId}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bill.paymentProofUrl != null)
              Image.network(
                bill.paymentProofUrl!,
                errorBuilder: (context, error, stackTrace) => 
                  const Text('Gagal memuat bukti pembayaran.'),
              )
            else
              const Text('Bukti tidak tersedia (Pembayaran Tunai).'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // PERBAIKAN: Hanya mengirim event ke BLoC
              context.read<AdminPanelBloc>().add(AdminPanelEvent.rejectBill(bill.id));
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Tolak', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              // PERBAIKAN: Hanya mengirim event ke BLoC
              context.read<AdminPanelBloc>().add(AdminPanelEvent.approveBill(bill.id));
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Setujui'),
          ),
        ],
      ),
    );
  }
}
