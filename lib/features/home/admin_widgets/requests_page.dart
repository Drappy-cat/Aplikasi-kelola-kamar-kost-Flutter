import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(req.type, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                _row('User', req.userName ?? '–'),
                _row('Kamar', req.roomCode ?? '–'),
                _row('Tanggal', req.date),
                _row('Catatan', req.note),
                const SizedBox(height: 8),
                Row(children: [
                  const Text('Status: ', style: TextStyle(color: Colors.black54)),
                  Chip(
                    label: Text(req.status),
                    backgroundColor: req.status == 'Pending'
                        ? Colors.orange.shade100
                        : req.status == 'Disetujui'
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                  )
                ]),
                const SizedBox(height: 8),
                if (req.status == 'Pending')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<AdminPanelBloc>().add(AdminPanelEvent.processRequest(req, false));
                        },
                        child: const Text('Tolak', style: TextStyle(color: Colors.red)),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          context.read<AdminPanelBloc>().add(AdminPanelEvent.processRequest(req, true));
                        },
                        child: const Text('Setujui'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        SizedBox(width: 140, child: Text(k, style: const TextStyle(color: Colors.black54))),
        Expanded(child: Text(v)),
      ]),
    );
  }
}
