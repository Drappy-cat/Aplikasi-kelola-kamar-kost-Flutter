import 'package:flutter/material.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdminComplaintScreen extends StatefulWidget {
  const AdminComplaintScreen({super.key});

  @override
  State<AdminComplaintScreen> createState() => _AdminComplaintScreenState();
}

class _AdminComplaintScreenState extends State<AdminComplaintScreen> {
  late List<Complaint> _allComplaints;
  List<Complaint> _filteredComplaints = [];
  final _searchController = TextEditingController();
  String? _selectedStatusFilter;
  String? _selectedCategoryFilter;

  final List<String> _statuses = ['All', 'Pending', 'In Progress', 'Resolved'];
  final List<String> _categories = ['All', 'Kerusakan Fasilitas', 'Kebersihan', 'Keamanan', 'Lainnya'];

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
    setState(() {
      _allComplaints = DummyService.getAllComplaints();
      _allComplaints.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _filterComplaints();
    });
  }

  void _filterComplaints() {
    setState(() {
      _filteredComplaints = _allComplaints.where((c) {
        final titleMatches = c.title.toLowerCase().contains(_searchController.text.toLowerCase());
        final statusMatches = _selectedStatusFilter == null || _selectedStatusFilter == 'All' || c.status == _selectedStatusFilter;
        final categoryMatches = _selectedCategoryFilter == null || _selectedCategoryFilter == 'All' || c.category == _selectedCategoryFilter;
        return titleMatches && statusMatches && categoryMatches;
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

  void _updateComplaintStatus(Complaint complaint, String newStatus) {
    setState(() {
      DummyService.updateComplaintStatus(complaint.id, newStatus);
      _loadComplaints(); // Reload to reflect changes and re-filter
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status pengaduan ${complaint.title} diubah menjadi $newStatus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Pengaduan Admin'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _selectedStatusFilter ?? 'All',
            onSelected: (String result) {
              setState(() {
                _selectedStatusFilter = result;
                _filterComplaints();
              });
            },
            itemBuilder: (BuildContext context) => _statuses.map((String status) {
              return PopupMenuItem<String>(
                value: status,
                child: Text(status == 'All' ? 'Semua Status' : status),
              );
            }).toList(),
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter Status',
          ),
          PopupMenuButton<String>(
            initialValue: _selectedCategoryFilter ?? 'All',
            onSelected: (String result) {
              setState(() {
                _selectedCategoryFilter = result;
                _filterComplaints();
              });
            },
            itemBuilder: (BuildContext context) => _categories.map((String category) {
              return PopupMenuItem<String>(
                value: category,
                child: Text(category == 'All' ? 'Semua Kategori' : category),
              );
            }).toList(),
            icon: const Icon(Icons.category),
            tooltip: 'Filter Kategori',
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
                                  PopupMenuButton<String>(
                                    initialValue: complaint.status,
                                    onSelected: (String newStatus) {
                                      _updateComplaintStatus(complaint, newStatus);
                                    },
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(value: 'Pending', child: Text('Pending')),
                                      const PopupMenuItem<String>(value: 'In Progress', child: Text('In Progress')),
                                      const PopupMenuItem<String>(value: 'Resolved', child: Text('Resolved')),
                                    ],
                                    child: Chip(
                                      label: Text(complaint.status, style: const TextStyle(color: Colors.white)),
                                      backgroundColor: _getStatusColor(complaint.status),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('Kategori: ${complaint.category}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700)),
                              Text('ID Pengguna: ${complaint.userId}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700)),
                              Text('ID Kamar: ${complaint.roomId}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700)),
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
    );
  }
}
