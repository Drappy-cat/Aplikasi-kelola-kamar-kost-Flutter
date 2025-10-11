import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/features/billing/bloc/bill_bloc.dart';
import 'package:tes/shared/models/bill.dart';

class UserBillScreen extends StatelessWidget {
  const UserBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillBloc()..add(const BillEvent.loadBills()),
      child: const UserBillView(),
    );
  }
}

class UserBillView extends StatelessWidget {
  const UserBillView({super.key});

  Future<void> _showPaymentConfirmation(BuildContext context, Bill bill) async {
    if (bill.status != 'Belum Lunas') return;

    final bloc = context.read<BillBloc>();

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: const Text('Pilih metode pembayaran Anda.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              bloc.add(BillEvent.confirmCashPayment(bill.id));
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Bayar Tunai'),
          ),
          ElevatedButton(
            onPressed: () {
              final proofUrl = 'https://picsum.photos/seed/${bill.id}/400/600';
              bloc.add(BillEvent.submitTransferProof(bill.id, proofUrl));
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Transfer Bank'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan Saya'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF72585), Color(0xFF5B2EBC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/payment_history'),
            tooltip: 'Riwayat Pembayaran',
          ),
        ],
      ),
      body: BlocBuilder<BillBloc, BillState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message)),
            loaded: (bills) {
              if (bills.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada tagihan aktif.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  final bill = bills[index];
                  final bool isPaid = bill.status == 'Lunas';
                  final bool isPending = bill.status == 'Menunggu Konfirmasi';

                  final Color statusColor = isPaid
                      ? Colors.green
                      : isPending
                          ? Colors.orange
                          : Colors.red;

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: statusColor.withOpacity(0.1),
                        child: Icon(isPaid ? Icons.check_circle : Icons.receipt_long, color: statusColor),
                      ),
                      title: Text('Tagihan ${bill.period}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Rp ${bill.amount.toStringAsFixed(0)}'),
                      trailing: Chip(
                        label: Text(bill.status, style: const TextStyle(color: Colors.white)),
                        backgroundColor: statusColor,
                      ),
                      onTap: () => _showPaymentConfirmation(context, bill),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
