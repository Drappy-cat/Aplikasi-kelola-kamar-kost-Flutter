import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade100.withOpacity(0.5),
              Colors.purple.shade100.withOpacity(0.5)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            // Developer Profile Section
            Center(
              child: Column(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/profile.png'), // Placeholder for profile image
                    backgroundColor: Colors.white, // Fallback background
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rizma Indra Pramudya',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // About Me Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade50.withOpacity(0.7),
                      Colors.purple.shade50.withOpacity(0.7)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tentang Saya',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                      ),
                      const Divider(color: Colors.deepPurpleAccent),
                      const SizedBox(height: 10),
                      _buildInfoRow(context, 'Nama', 'Rizma Indra Pramudya'),
                      _buildInfoRow(context, 'Berkuliah di', 'Universitas Negeri Surabaya'),
                      _buildInfoRow(context, 'Prodi', 'Informatika dengan NIM 24111814117'),
                    ],
                  ),
                ),
              ),
            ),

            // About Application Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade50.withOpacity(0.7),
                      Colors.purple.shade50.withOpacity(0.7)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tentang Aplikasi',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                      ),
                      const Divider(color: Colors.deepPurpleAccent),
                      const SizedBox(height: 10),
                      Text(
                        '''Aplikasi ini adalah sebuah [jelaskan aplikasi Anda, misal: aplikasi manajemen tugas pribadi] yang dirancang untuk membantu Anda [sebutkan tujuan utama, misal: mengatur jadwal harian dan meningkatkan produktivitas].

Fungsi utamanya meliputi [sebutkan fungsi-fungsi utama, misal: membuat daftar tugas, mengatur pengingat, melacak kemajuan proyek]. Manfaat yang Anda dapatkan adalah [sebutkan manfaat, misal: mengurangi stres, memastikan tidak ada tugas yang terlewat, dan mencapai tujuan pribadi dengan lebih efisien].''',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
