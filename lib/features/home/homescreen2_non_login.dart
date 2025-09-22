import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/services/auth_service.dart';

class SampleItem {
  final String _title;
  final String _subtitle;

  const SampleItem(this._title, this._subtitle);

  String get title => _title;
  String get subtitle => _subtitle;
}

class HomeScreen2NonLogin extends StatelessWidget {
  const HomeScreen2NonLogin({super.key});

  // Data dummy untuk ditampilkan di list
  final List<SampleItem> _items = const [
    SampleItem('Item Satu', 'Ini adalah deskripsi untuk item satu.'),
    SampleItem('Item Dua', 'Ini adalah deskripsi untuk item dua.'),
    SampleItem('Item Tiga', 'Ini adalah deskripsi untuk item tiga.'),
  ];

  @override
  Widget build(BuildContext context) {
    final userName = AuthService.currentUser?.fullName ?? AuthService.currentUser?.username ?? 'Pengguna';

    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang, $userName'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF72585), Color(0xFF5B2EBC)], // Gradasi Pink ke Ungu
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      // Tampilan body yang bersih dengan ListView
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
              // Penggunaan Getter: item.title dan item.subtitle memanggil getter
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
