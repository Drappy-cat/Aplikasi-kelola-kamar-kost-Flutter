import 'package:flutter/material.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart'; // <-- IMPORT LOCATOR

class SampleItem {
  final String _title;
  final String _subtitle;

  const SampleItem(this._title, this._subtitle);

  String get title => _title;
  String get subtitle => _subtitle;
}

class HomeScreen2NonLogin extends StatelessWidget {
  const HomeScreen2NonLogin({super.key});

  final List<SampleItem> _items = const [
    SampleItem('Item Satu', 'Ini adalah deskripsi untuk item satu.'),
    SampleItem('Item Dua', 'Ini adalah deskripsi untuk item dua.'),
    SampleItem('Item Tiga', 'Ini adalah deskripsi untuk item tiga.'),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();
    final userName = authService.currentUser?.fullName ?? authService.currentUser?.username ?? 'Pengguna';

    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang, $userName'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF72585), Color(0xFF5B2EBC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          // Tombol tema di sini tidak perlu AnimatedBuilder karena tidak ada ThemeService di sini
          // Jika ingin ada toggle tema di sini, perlu diimplementasikan ulang
          // Untuk saat ini, kita biarkan kosong atau hapus jika tidak diperlukan
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
