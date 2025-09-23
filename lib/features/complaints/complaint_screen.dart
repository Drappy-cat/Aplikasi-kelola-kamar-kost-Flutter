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
  List<Complaint> _filteredComplaints = [];
  final _searchController = TextEditingController();
  String? _selectedStatusFilter;

  @override
  void initState() {
    super.initState();
    _loadComplaints();
    _searchController.addListener(_filterComplaints);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadComplaints() {
    final userId = AuthService.currentUser?.id ?? '';
    setState(() {
      _complaints = DummyService.getComplaintsForUser(userId);
      _complaints.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _filterComplaints(); // Initial filter
    });
  }

  void _filterComplaints() {
    setState(() {
      _filteredComplaints = _complaints.where((c) {
        final titleMatches = c.title.toLowerCase().contains(_searchController.text.toLowerCase());
        final statusMatches = _selectedStatusFilter == null || c.status == _selectedStatusFilter;
        return titleMatches && statusMatches;
      }).toList();
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
    final List<String> categories = ["Kerusakan Fasilitas", "Kebersihan", "Keamanan", "Lainnya"];
    String? selectedCategory = categories.first;
    List<String> selectedImageUrls = [];

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Buat Pengaduan Baru'),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Judul Pengaduan', border: OutlineInputBorder()),
                        validator: (v) => (v == null || v.isEmpty) ? 'Judul tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        validator: (v) => (v == null) ? 'Kategori harus dipilih' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
                        maxLines: 3,
                        validator: (v) => (v == null || v.isEmpty) ? 'Deskripsi tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {
                          // Simulate image picking
                          setState(() {
                            final imageId = DateTime.now().millisecondsSinceEpoch;
                            selectedImageUrls.add('https://picsum.photos/seed/$imageId/200/300');
                          });
                        },
                        icon: const Icon(Icons.add_a_photo),
                        label: const Text("Tambah Foto"),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: selectedImageUrls.map((url) => Chip(
                          label: Text('Image ${selectedImageUrls.indexOf(url) + 1}'),
                          onDeleted: () {
                            setState(() {
                              selectedImageUrls.remove(url);
                            });
                          },
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final AppUser? user = AuthService.currentUser;
                      if (user != null && user.roomId != null) {
                        DummyService.addComplaint(
                          userId: user.id,
                          roomId: user.roomId!,
                          title: titleController.text,
                          description: descriptionController.text,
                          category: selectedCategory!,
                          imageUrls: selectedImageUrls,
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
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTenant = AuthService.currentUser?.roomId != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaduan Saya'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                _selectedStatusFilter = result == 'All' ? null : result;
                _filterComplaints();
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'All', child: Text('Semua Status')),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(value: 'Pending', child: Text('Pending')),
              const PopupMenuItem<String>(value: 'In Progress', child: Text('In Progress')),
              const PopupMenuItem<String>(value: 'Resolved', child: Text('Resolved')),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari berdasarkan judul',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: _filteredComplaints.isEmpty
                ? const Center(
                    child: Text('Tidak ada pengaduan yang cocok.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _filteredComplaints.length,
                    itemBuilder: (context, index) {
                      final complaint = _filteredComplaints[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      complaint.title,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Chip(
                                    label: Text(complaint.status, style: const TextStyle(color: Colors.white)),
                                    backgroundColor: _getStatusColor(complaint.status),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(complaint.category, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700)),
                              const SizedBox(height: 8),
                              Text(complaint.description),
                              if (complaint.imageUrls.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: SizedBox(
                                    height: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: complaint.imageUrls.length,
                                      itemBuilder: (context, imgIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.network(
                                              complaint.imageUrls[imgIndex],
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child, progress) =>
                                                  progress == null ? child : const Center(child: CircularProgressIndicator()),
                                              errorBuilder: (context, error, stack) =>
                                                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Dikirim: ${timeago.format(complaint.createdAt, locale: 'id')}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
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
