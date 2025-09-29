import 'package:flutter/material.dart';
import 'package:tes/features/billing/payment_proof_detail_screen.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  late List<Bill> _paidBills;

  @override
  void initState() {
    super.initState();
    _loadPaidBills();
  }

  void _loadPaidBills() {
    final userId = AuthService.currentUser?.id ?? '';
    setState(() {
      // Filter bills that are either confirmed or paid
      _paidBills = DummyService.getBillsForUser(userId)
          .where((bill) => bill.status != 'Belum Lunas')
          .toList();
      _paidBills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Lunas':
        return Colors.green;
      case 'Menunggu Konfirmasi':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pembayaran'),
      ),
      body: _paidBills.isEmpty
          ? const Center(
              child: Text('Belum ada riwayat pembayaran.', style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _paidBills.length,
              itemBuilder: (context, index) {
                final bill = _paidBills[index];
                final bool hasProof = bill.paymentProofUrl != null;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: ListTile(
                    title: Text('Pembayaran ${bill.period}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jumlah: Rp ${bill.amount}'),
                        const SizedBox(height: 4),
                        Text(
                          'Status: ${bill.status}',
                          style: TextStyle(color: _getStatusColor(bill.status), fontWeight: FontWeight.bold),
                        ),
                        if (bill.paymentMethod != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('Metode: ${bill.paymentMethod}', style: TextStyle(color: Colors.grey.shade700)),
                          ),
                      ],
                    ),
                    trailing: hasProof
                        ? const Icon(Icons.chevron_right)
                        : null,
                    onTap: hasProof
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentProofDetailScreen(bill: bill),
                              ),
                            );
                          }
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
