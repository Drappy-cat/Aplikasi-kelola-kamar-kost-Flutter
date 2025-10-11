import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final DummyService _dummyService = getIt<DummyService>();
  final AuthService _authService = getIt<AuthService>();

  late List<Bill> _paidBills;

  @override
  void initState() {
    super.initState();
    // Menggunakan instance service
    final userId = _authService.currentUser?.id ?? '';
    if (userId.isNotEmpty) {
      _paidBills = _dummyService.getBillsForUser(userId)
          .where((bill) => bill.status == 'Lunas')
          .toList();
    } else {
      _paidBills = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pembayaran'),
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
      ),
      body: _paidBills.isEmpty
          ? const Center(
              child: Text('Belum ada riwayat pembayaran.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _paidBills.length,
              itemBuilder: (context, index) {
                final bill = _paidBills[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                    title: Text('Pembayaran ${bill.period}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Dibayar via ${bill.paymentMethod ?? 'N/A'} pada ${DateFormat.yMMMd().format(bill.createdAt)}'),
                    trailing: Text(
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(bill.amount),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
