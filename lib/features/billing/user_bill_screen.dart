import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tes/features/billing/bloc/bill_bloc.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserBillScreen extends StatelessWidget {
  const UserBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillBloc()..add(LoadBills()),
      child: const UserBillView(),
    );
  }
}

class UserBillView extends StatelessWidget {
  const UserBillView({super.key});

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

  Future<void> _showPaymentOptionsDialog(BuildContext context, Bill bill) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Pilih Metode Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Bayar Tunai'),
              onTap: () {
                context.read<BillBloc>().add(ConfirmCashPayment(bill.id));
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Konfirmasi pembayaran tunai berhasil. Menunggu persetujuan admin.')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.transfer_within_a_station),
              title: const Text('Transfer Bank'),
              onTap: () {
                Navigator.pop(dialogContext);
                _showUploadPaymentProofDialog(context, bill);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  Future<void> _showUploadPaymentProofDialog(BuildContext context, Bill bill) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (stfContext, stfSetState) {
            return AlertDialog(
              title: const Text('Unggah Bukti Pembayaran'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            stfSetState(() {
                              pickedFile = image;
                            });
                          }
                        },
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Galeri'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final XFile? image = await picker.pickImage(source: ImageSource.camera);
                          if (image != null) {
                            stfSetState(() {
                              pickedFile = image;
                            });
                          }
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Kamera'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    pickedFile == null
                        ? 'Belum ada gambar yang dipilih.'
                        : 'File: ${pickedFile!.name}',
                    style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
                ElevatedButton(
                  onPressed: pickedFile == null
                      ? null // Disable button if no file is picked
                      : () {
                          context.read<BillBloc>().add(SubmitTransferProof(bill.id, pickedFile!.path));
                          Navigator.pop(dialogContext);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Bukti pembayaran berhasil diunggah!')),
                          );
                        },
                  child: const Text('Unggah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan Saya'),
      ),
      body: BlocBuilder<BillBloc, BillState>(
        builder: (context, state) {
          if (state is BillLoading || state is BillInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BillLoaded) {
            if (state.bills.isEmpty) {
              return const Center(
                child: Text('Belum ada tagihan.', style: TextStyle(fontSize: 16, color: Colors.grey)),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.bills.length,
              itemBuilder: (context, index) {
                final bill = state.bills[index];
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
                            onPressed: () => _showPaymentOptionsDialog(context, bill),
                            child: const Text('Bayar'),
                          )
                        : null,
                  ),
                );
              },
            );
          }
          if (state is BillError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Terjadi Kesalahan: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return const Center(child: Text('Silakan muat ulang halaman.'));
        },
      ),
    );
  }
}
