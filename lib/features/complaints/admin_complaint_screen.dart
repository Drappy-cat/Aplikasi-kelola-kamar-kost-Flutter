import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/shared/models/complaint.dart';

// PERBAIKAN: Diubah menjadi StatelessWidget
class AdminComplaintScreen extends StatelessWidget {
  const AdminComplaintScreen({super.key});

  void _showStatusChangeDialog(BuildContext context, Complaint complaint) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ubah Status Pengaduan'),
        content: DropdownButton<String>(
          value: complaint.status,
          isExpanded: true,
          items: ['Pending', 'In Progress', 'Selesai', 'Ditolak']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (newStatus) {
            if (newStatus != null) {
              // PERBAIKAN: Mengirim event ke BLoC
              context.read<AdminPanelBloc>().add(
                    AdminPanelEvent.updateComplaintStatus(
                      complaintId: complaint.id,
                      newStatus: newStatus,
                    ),
                  );
              Navigator.of(dialogContext).pop();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan BlocBuilder untuk mendapatkan state terbaru dari AdminPanelBloc
    return BlocBuilder<AdminPanelBloc, AdminPanelState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Semua', label: Text('Semua')),
                  ButtonSegment(value: 'Pending', label: Text('Pending')),
                  ButtonSegment(value: 'In Progress', label: Text('Dikerjakan')),
                  ButtonSegment(value: 'Selesai', label: Text('Selesai')),
                ],
                // PERBAIKAN: Nilai selected diambil dari state BLoC
                selected: {state.complaintStatusFilter},
                onSelectionChanged: (newSelection) {
                  // PERBAIKAN: Mengirim event filter ke BLoC
                  context
                      .read<AdminPanelBloc>()
                      .add(AdminPanelEvent.filterComplaints(newSelection.first));
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                // PERBAIKAN: Data diambil dari filteredComplaints di state BLoC
                itemCount: state.filteredComplaints.length,
                itemBuilder: (context, index) {
                  final complaint = state.filteredComplaints[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(complaint.title),
                      subtitle: Text('Kamar ${complaint.roomId} - ${complaint.category}'),
                      trailing: Chip(
                        label: Text(complaint.status),
                      ),
                      onTap: () => _showStatusChangeDialog(context, complaint),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
