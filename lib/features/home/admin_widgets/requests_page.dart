import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/shared/models/request.dart';

class RequestsPage extends StatelessWidget {
  final List<Request> requests;
  const RequestsPage({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(
        child: Text('Tidak ada pengajuan baru.', style: TextStyle(color: Colors.grey)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];
        return _RequestCard(request: req);
      },
    );
  }
}

// Widget baru untuk menampilkan kartu pengajuan yang lebih detail
class _RequestCard extends StatelessWidget {
  final Request request;

  const _RequestCard({required this.request});

  // Helper untuk mendapatkan ikon berdasarkan tipe dan status
  IconData _getIcon() {
    if (request.status == 'Menunggu Pembayaran') return Icons.hourglass_bottom;
    if (request.status == 'Menunggu Persetujuan') return Icons.pending_actions;
    if (request.status == 'Disetujui') return Icons.check_circle;
    if (request.status == 'Ditolak') return Icons.cancel;
    return Icons.inbox;
  }

  // Helper untuk mendapatkan warna berdasarkan status
  Color _getColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (request.status) {
      case 'Menunggu Pembayaran':
      case 'Menunggu Persetujuan':
        return Colors.orange;
      case 'Disetujui':
        return Colors.green;
      case 'Ditolak':
        return colorScheme.error;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(_getIcon(), color: color),
            ),
            title: Text(request.type, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Oleh: ${request.userName ?? 'N/A'}'),
            trailing: Chip(
              label: Text(request.status, style: const TextStyle(color: Colors.white)),
              backgroundColor: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                _buildInfoRow(Icons.room_service_outlined, 'Kamar', request.roomCode ?? '-'),
                _buildInfoRow(Icons.event, 'Tanggal Pengajuan', request.date),
                if (request.paymentMethod != null)
                  _buildInfoRow(Icons.payment, 'Metode Bayar', request.paymentMethod!),
                if (request.virtualAccountNumber != null)
                  _buildInfoRow(Icons.pin, 'Nomor VA', request.virtualAccountNumber!),
                if (request.paymentDueDate != null)
                  _buildInfoRow(
                    Icons.timer_outlined,
                    'Batas Waktu Bayar',
                    DateFormat.yMMMd().add_jm().format(request.paymentDueDate!),
                  ),
                const SizedBox(height: 8),
                Text(request.note, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
              ],
            ),
          ),
          // Tampilkan tombol aksi hanya jika statusnya memerlukan persetujuan admin
          if (request.status == 'Menunggu Persetujuan')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<AdminPanelBloc>().add(AdminPanelEvent.processRequest(request, false));
                    },
                    child: const Text('Tolak', style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      context.read<AdminPanelBloc>().add(AdminPanelEvent.processRequest(request, true));
                    },
                    child: const Text('Setujui'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
