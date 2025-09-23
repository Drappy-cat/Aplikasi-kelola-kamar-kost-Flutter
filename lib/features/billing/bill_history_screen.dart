
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

class BillHistoryScreen extends StatefulWidget {
  const BillHistoryScreen({super.key});

  @override
  State<BillHistoryScreen> createState() => _BillHistoryScreenState();
}

class _BillHistoryScreenState extends State<BillHistoryScreen> {
  late List<Bill> _bills;

  @override
  void initState() {
    super.initState();
    // Get the current user's ID from AuthService
    final userId = AuthService.getCurrentUser()?.id ?? '';
    // Fetch bills for that user
    _bills = DummyService.getBillsForUser(userId);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Lunas':
        return Colors.green;
      case 'Menunggu Konfirmasi':
        return Colors.orange;
      case 'Belum Lunas':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showConfirmationDialog(Bill bill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: Text('Anda akan mengonfirmasi pembayaran untuk tagihan ${bill.period}. Lanjutkan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              // For now, this is a dummy action.
              // In a real app, you would trigger an image picker here.
              DummyService.submitPaymentProof(bill.id, 'assets/kamar_kost/bukti_tf.png');
              setState(() {
                // Re-fetch the bills to update the UI
                final userId = AuthService.getCurrentUser()?.id ?? '';
                _bills = DummyService.getBillsForUser(userId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bukti pembayaran terkirim, menunggu konfirmasi admin.')),
              );
            },
            child: const Text('Kirim Bukti'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Tagihan'),
      ),
      body: _bills.isEmpty
          ? const Center(child: Text('Tidak ada riwayat tagihan.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _bills.length,
              itemBuilder: (context, index) {
                final bill = _bills[index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    title: Text(
                      'Tagihan ${bill.period}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4.0),
                        Text(
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                              .format(bill.amount),
                        ),
                        const SizedBox(height: 8.0),
                        Chip(
                          label: Text(
                            bill.status,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: _getStatusColor(bill.status),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ],
                    ),
                    trailing: bill.status == 'Belum Lunas'
                        ? ElevatedButton(
                            onPressed: () => _showConfirmationDialog(bill),
                            child: const Text('Bayar'),
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
