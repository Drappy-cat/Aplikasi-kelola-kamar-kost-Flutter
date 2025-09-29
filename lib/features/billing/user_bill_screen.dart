import 'package:flutter/material.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserBillScreen extends StatefulWidget {
  const UserBillScreen({super.key});

  @override
  State<UserBillScreen> createState() => _UserBillScreenState();
}

class _UserBillScreenState extends State<UserBillScreen> {
  late List<Bill> _bills;

  @override
  void initState() {
    super.initState();
    _loadBills();
  }

  void _loadBills() {
    final userId = AuthService.currentUser?.id ?? '';
    setState(() {
      _bills = DummyService.getBillsForUser(userId);
      _bills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
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

  Future<void> _showPaymentOptionsDialog(Bill bill) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Metode Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Bayar Tunai'),
              onTap: () {
                DummyService.confirmCashPayment(bill.id);
                _loadBills();
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Konfirmasi pembayaran tunai berhasil. Menunggu persetujuan admin.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.transfer_within_a_station),
              title: const Text('Transfer Bank'),
              onTap: () {
                Navigator.pop(context); // Close this dialog first
                _showUploadPaymentProofDialog(bill); // Then open the upload dialog
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  Future<void> _showUploadPaymentProofDialog(Bill bill) async {
    final formKey = GlobalKey<FormState>();
    String? paymentProofUrl; // This would typically come from an image picker

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unggah Bukti Pembayaran'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'URL Bukti Pembayaran (Dummy)', border: OutlineInputBorder()),
                onChanged: (value) => paymentProofUrl = value,
                validator: (v) => (v == null || v.isEmpty) ? 'URL tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              const Text('Fitur unggah gambar sebenarnya akan diimplementasikan di sini.', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate() && paymentProofUrl != null) {
                DummyService.submitPaymentProof(bill.id, paymentProofUrl!);
                _loadBills();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bukti pembayaran berhasil diunggah!')),
                );
              }
            },
            child: const Text('Unggah'),
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
      ),
      body: _bills.isEmpty
          ? const Center(
              child: Text('Belum ada tagihan.', style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _bills.length,
              itemBuilder: (context, index) {
                final bill = _bills[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: ListTile(
                    title: Text('Tagihan Periode ${bill.period}', style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        if (bill.paymentProofUrl != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('Bukti Pembayaran: Diunggah', style: TextStyle(color: Colors.grey.shade700)),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          'Dibuat: ${timeago.format(bill.createdAt, locale: 'id')}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: bill.status == 'Belum Lunas'
                        ? ElevatedButton(
                            onPressed: () => _showPaymentOptionsDialog(bill),
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
