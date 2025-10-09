import 'package:flutter/material.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

class AdminComplaintScreen extends StatefulWidget {
  const AdminComplaintScreen({super.key});

  @override
  State<AdminComplaintScreen> createState() => _AdminComplaintScreenState();
}

class _AdminComplaintScreenState extends State<AdminComplaintScreen> {
  final DummyService _dummyService = getIt<DummyService>();
  late List<Complaint> _allComplaints;
  String _filterStatus = 'Semua';

  @override
  void initState() {
    super.initState();
    _allComplaints = _dummyService.getAllComplaints();
  }

  void _showStatusChangeDialog(Complaint complaint) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Status Pengaduan'),
        content: DropdownButton<String>(
          value: complaint.status,
          isExpanded: true,
          items: ['Pending', 'In Progress', 'Selesai', 'Ditolak']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (newStatus) {
            if (newStatus != null) {
              // PERBAIKAN: Menggunakan .then() untuk refresh UI setelah async selesai
              _dummyService.updateComplaintStatus(complaint.id, newStatus).then((_) {
                setState(() {
                  // Cukup refresh data dari service
                  _allComplaints = _dummyService.getAllComplaints();
                });
              });
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredComplaints = _filterStatus == 'Semua'
        ? _allComplaints
        : _allComplaints.where((c) => c.status == _filterStatus).toList();

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
            selected: {_filterStatus},
            onSelectionChanged: (newSelection) {
              setState(() {
                _filterStatus = newSelection.first;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredComplaints.length,
            itemBuilder: (context, index) {
              final complaint = filteredComplaints[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(complaint.title),
                  subtitle: Text('Kamar ${complaint.roomId} - ${complaint.category}'),
                  trailing: Chip(
                    label: Text(complaint.status),
                  ),
                  onTap: () => _showStatusChangeDialog(complaint),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
