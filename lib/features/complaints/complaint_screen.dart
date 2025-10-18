import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes/features/complaints/bloc/complaint_bloc.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:timeago/timeago.dart' as timeago;

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComplaintBloc()..add(const ComplaintEvent.load()),
      child: const ComplaintView(),
    );
  }
}

class ComplaintView extends StatefulWidget {
  const ComplaintView({super.key});

  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
  final _searchController = TextEditingController();
  String? _selectedStatusFilter;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onFilterChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onFilterChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onFilterChanged() {
    context.read<ComplaintBloc>().add(ComplaintEvent.filterChanged(
          searchQuery: _searchController.text,
          statusFilter: _selectedStatusFilter,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final bool isTenant = getIt<AuthService>().currentUser?.roomId != null;

    return BlocListener<ComplaintBloc, ComplaintState>(
      listener: (context, state) {
        if (state.submissionSuccess != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.submissionSuccess!), backgroundColor: Colors.green),
          );
        }
        if (state.submissionError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.submissionError!), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pengaduan Saya'),
          actions: [_buildFilterMenu(context)],
        ),
        body: Column(
          children: [
            _buildSearchBar(context),
            Expanded(
              child: BlocBuilder<ComplaintBloc, ComplaintState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.error != null) {
                    return Center(child: Text(state.error!));
                  }
                  if (state.filteredComplaints.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada pengaduan yang cocok.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    );
                  }
                  return _buildComplaintList(state.filteredComplaints);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: isTenant
            ? FloatingActionButton.extended(
                onPressed: () => _showAddComplaintDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Buat Pengaduan'),
              )
            : null,
      ),
    );
  }

  Widget _buildFilterMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        setState(() {
          _selectedStatusFilter = result == 'All' ? null : result;
        });
        _onFilterChanged();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(value: 'All', child: Text('Semua Status')),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(value: 'Pending', child: Text('Pending')),
        const PopupMenuItem<String>(value: 'In Progress', child: Text('In Progress')),
        const PopupMenuItem<String>(value: 'Resolved', child: Text('Resolved')),
      ],
      icon: const Icon(Icons.filter_list),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildComplaintList(List<Complaint> complaints) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        final complaint = complaints[index];
        return _ComplaintCard(complaint: complaint);
      },
    );
  }

  Future<void> _showAddComplaintDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final List<String> categories = ["Kerusakan Fasilitas", "Kebersihan", "Keamanan", "Lainnya"];
    String? selectedCategory = categories.first;
    List<String> selectedImageUrls = [];

    await showDialog(
      context: context,
      builder: (dialogContext) {
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
                        value: selectedCategory,
                        decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(value: category, child: Text(category));
                        }).toList(),
                        onChanged: (newValue) => setState(() => selectedCategory = newValue),
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
                      // Image picking simulation can be improved
                      OutlinedButton.icon(
                        onPressed: () => setState(() {
                          final imageId = DateTime.now().millisecondsSinceEpoch;
                          selectedImageUrls.add('https://picsum.photos/seed/$imageId/200/300');
                        }),
                        icon: const Icon(Icons.add_a_photo),
                        label: const Text("Tambah Foto"),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: selectedImageUrls.map((url) => Chip(
                          label: Text('Image ${selectedImageUrls.indexOf(url) + 1}'),
                          onDeleted: () => setState(() => selectedImageUrls.remove(url)),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                BlocBuilder<ComplaintBloc, ComplaintState>(
                  bloc: context.read<ComplaintBloc>(),
                  builder: (context, state) {
                    return FilledButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<ComplaintBloc>().add(ComplaintEvent.add(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      category: selectedCategory!,
                                      imageUrls: selectedImageUrls,
                                    ));
                                Navigator.pop(context);
                              }
                            },
                      child: state.isSubmitting
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Text('Kirim'),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// Extracted widget for a single complaint card
class _ComplaintCard extends StatelessWidget {
  final Complaint complaint;

  const _ComplaintCard({required this.complaint});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Resolved': return Colors.green;
      case 'In Progress': return Colors.blue;
      case 'Pending': return Colors.orange;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text(complaint.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                            errorBuilder: (context, error, stack) => const Icon(Icons.broken_image, size: 50, color: Colors.grey),
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
  }
}
