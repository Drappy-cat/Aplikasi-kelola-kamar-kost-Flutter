import 'package:flutter/material.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  late List<Complaint> _complaints;

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }

  void _loadComplaints() {
    final userId = AuthService.currentUser?.id ?? '';
    setState(() {
      _complaints = DummyService.getComplaintsForUser(userId);
      _complaints.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Resolved':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> _showAddComplaintDialog() async {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buat Pengaduan Baru'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Judul Pengaduan', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.isEmpty) ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (v) => (v == null || v.isEmpty) ? 'Deskripsi tidak boleh kosong' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final AppUser? user = AuthService.currentUser;
                // Pemeriksaan ganda untuk memastikan user dan roomId tidak null
                if (user != null && user.roomId != null) {
                  DummyService.addComplaint(
                    userId: user.id,
                    roomId: user.roomId!, // Aman digunakan karena sudah diperiksa
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  _loadComplaints(); // Refresh the list
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pengaduan berhasil dikirim!')),
                  );
                } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gagal mengirim: Anda harus menjadi penghuni untuk membuat pengaduan.'), backgroundColor: Colors.red),
                  );
                }
              }
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cek apakah pengguna saat ini adalah penghuni (memiliki roomId)
    final bool isTenant = AuthService.currentUser?.roomId != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaduan Saya'),
      ),
      body: _complaints.isEmpty
          ? const Center(
              child: Text('Belum ada pengaduan.', style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _complaints.length,
              itemBuilder: (context, index) {
                final complaint = _complaints[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: ListTile(
                    title: Text(complaint.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(complaint.description),
                        const SizedBox(height: 8),
                        Text(
                          'Dikirim: ${timeago.format(complaint.createdAt, locale: 'id')}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(complaint.status, style: const TextStyle(color: Colors.white)),
                      backgroundColor: _getStatusColor(complaint.status),
                    ),
                  ),
                );
              },
            ),
      // Tombol hanya akan ditampilkan jika pengguna adalah penghuni
      floatingActionButton: isTenant
          ? FloatingActionButton.extended(
              onPressed: _showAddComplaintDialog,
              icon: const Icon(Icons.add),
              label: const Text('Buat Pengaduan'),
            )
          : null,
    );
  }
}
