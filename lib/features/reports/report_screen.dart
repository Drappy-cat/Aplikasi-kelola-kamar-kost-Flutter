import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Map<String, dynamic>? _reportData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  void _fetchReportData() {
    setState(() => _isLoading = true);
    // Ambil data dari service
    final data = getIt<DummyService>().getAdminReportSummary();
    // Delay untuk simulasi loading
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _reportData = data;
          _isLoading = false;
        });
      }
    });
  }

  String _formatCurrency(num amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Ringkasan'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchReportData,
            tooltip: 'Perbarui Laporan',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reportData == null
              ? const Center(child: Text('Gagal memuat data laporan.'))
              : _buildReportBody(),
    );
  }

  Widget _buildReportBody() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildReportCard(
          context,
          title: 'Laporan Keuangan',
          icon: Icons.monetization_on_outlined,
          color: Colors.green,
          children: [
            _buildInfoRow('Total Pendapatan (Lunas)', _formatCurrency(_reportData!['totalRevenue'])),
            _buildInfoRow('Potensi Pendapatan (Tertunda)', _formatCurrency(_reportData!['pendingRevenue'])),
          ],
        ),
        _buildReportCard(
          context,
          title: 'Laporan Okupansi Kamar',
          icon: Icons.bed_outlined,
          color: Colors.blue,
          children: [
            _buildInfoRow('Tingkat Okupansi', '${_reportData!['occupancyRate'].toStringAsFixed(1)}%'),
            _buildInfoRow('Kamar Terisi', _reportData!['occupiedRooms'].toString()),
            _buildInfoRow('Kamar Kosong', _reportData!['vacantRooms'].toString()),
            _buildInfoRow('Total Kamar', _reportData!['totalRooms'].toString()),
          ],
        ),
        _buildReportCard(
          context,
          title: 'Laporan Aktivitas & Masalah',
          icon: Icons.summarize_outlined,
          color: Colors.orange,
          children: [
            _buildInfoRow('Pengaduan Pending', _reportData!['pendingComplaints'].toString()),
            _buildInfoRow('Pengajuan Pending', _reportData!['pendingRequests'].toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildReportCard(BuildContext context, {required String title, required IconData icon, required Color color, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
