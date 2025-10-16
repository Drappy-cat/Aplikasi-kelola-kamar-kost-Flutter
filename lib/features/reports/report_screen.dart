import 'package:fl_chart/fl_chart.dart';
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
  int _touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  void _fetchReportData() {
    setState(() => _isLoading = true);
    final data = getIt<DummyService>().getAdminReportSummary();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _reportData = data;
          _isLoading = false;
        });
      }
    });
  }

  /// Logika untuk mengekspor data.
  /// Fitur ini dinonaktifkan sementara karena masalah dependensi.
  void _exportReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur ekspor sedang dalam perbaikan dan akan segera tersedia.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  String _formatCurrency(num amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Ringkasan'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reportData == null
              ? const Center(child: Text('Gagal memuat data laporan.'))
              : _buildReportBody(),
    );
  }

  Widget _buildReportBody() {
    return Column(
      children: [
        // --- BAGIAN AKSI CEPAT ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickAction(
                context,
                icon: Icons.refresh,
                label: 'Perbarui',
                onTap: _fetchReportData,
              ),
              _buildQuickAction(
                context,
                icon: Icons.download_outlined,
                label: 'Ekspor Laporan',
                onTap: _exportReport,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // --- BAGIAN DAFTAR LAPORAN ---
        Expanded(
          child: ListView(
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
              _buildOccupancyChartCard(context),
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
          ),
        ),
      ],
    );
  }

  // --- WIDGET-WIDGET HELPER ---

  /// Widget baru untuk tombol aksi cepat di bagian atas.
  Widget _buildQuickAction(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: onTap,
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(icon, color: colorScheme.primary, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildOccupancyChartCard(BuildContext context) {
    final int occupied = _reportData!['occupiedRooms'];
    final int vacant = _reportData!['vacantRooms'];

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
                const Icon(Icons.bed_outlined, color: Colors.blue, size: 28),
                const SizedBox(width: 12),
                Text('Laporan Okupansi Kamar', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                          _touchedIndex = -1;
                          return;
                        }
                        _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 60,
                  sections: [
                    _buildPieSection(occupied.toDouble(), 'Terisi', Colors.blue, isTouched: _touchedIndex == 0),
                    _buildPieSection(vacant.toDouble(), 'Kosong', Colors.blue.shade100, isTouched: _touchedIndex == 1),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegend(color: Colors.blue, text: 'Terisi ($occupied)'),
                const SizedBox(width: 24),
                _buildLegend(color: Colors.blue.shade100, text: 'Kosong ($vacant)'),
              ],
            )
          ],
        ),
      ),
    );
  }

  PieChartSectionData _buildPieSection(double value, String title, Color color, {bool isTouched = false}) {
    final fontSize = isTouched ? 16.0 : 14.0;
    final radius = isTouched ? 60.0 : 50.0;
    return PieChartSectionData(
      color: color,
      value: value,
      title: '${(value / _reportData!['totalRooms'] * 100).toStringAsFixed(0)}%',
      radius: radius,
      titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white, shadows: const [Shadow(color: Colors.black, blurRadius: 2)]),
    );
  }

  Widget _buildLegend({required Color color, required String text}) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 8),
        Text(text),
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
