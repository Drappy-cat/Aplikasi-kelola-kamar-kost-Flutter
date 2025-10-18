import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    var deviceInfo = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfo.webBrowserInfo);
      } else {
        switch (Platform.operatingSystem) {
          case 'android':
            deviceData = _readAndroidBuildData(await deviceInfo.androidInfo);
            break;
          case 'ios':
            deviceData = _readIosDeviceInfo(await deviceInfo.iosInfo);
            break;
          case 'linux':
            deviceData = _readLinuxDeviceInfo(await deviceInfo.linuxInfo);
            break;
          case 'macos':
            deviceData = _readMacOsDeviceInfo(await deviceInfo.macOsInfo);
            break;
          case 'windows':
            deviceData = _readWindowsDeviceInfo(await deviceInfo.windowsInfo);
            break;
          default:
            deviceData = {'Error': 'Platform not supported'};
            break;
        }
      }
    } catch (e) {
      deviceData = {'Error': 'Failed to get platform version: $e'};
    }

    if (mounted) {
      setState(() {
        _deviceData = deviceData;
        _isLoading = false;
      });
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'OS Version': build.version.release,
      'SDK int': build.version.sdkInt,
      'Device': build.device,
      'Model': build.model,
      'Product': build.product,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'Name': data.name,
      'System Name': data.systemName,
      'System Version': data.systemVersion,
      'Model': data.model,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'Name': data.name,
      'Version': data.version,
      'Pretty Name': data.prettyName,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'Browser Name': data.browserName.name,
      'App Name': data.appName,
      'App Version': data.appVersion,
      'Platform': data.platform,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'Computer Name': data.computerName,
      'Host Name': data.hostName,
      'OS Release': data.osRelease,
      'Model': data.model,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'Computer Name': data.computerName,
      'OS Version': data.displayVersion,
    };
  }

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
              Colors.blue.shade100.withAlpha(128),
              Colors.purple.shade100.withAlpha(128),
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
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    backgroundColor: Colors.white,
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
            _buildInfoCard(
              context,
              title: 'Tentang Saya',
              children: [
                _buildInfoRow(context, 'Nama', 'Rizma Indra Pramudya'),
                _buildInfoRow(context, 'Berkuliah di', 'Universitas Negeri Surabaya'),
                _buildInfoRow(context, 'Prodi', 'Informatika dengan NIM 24111814117'),
              ],
            ),

            const SizedBox(height: 20),

            // Device Info Section
            _buildInfoCard(
              context,
              title: 'Informasi Perangkat',
              children: _isLoading
                  ? [const Center(child: CircularProgressIndicator())]
                  : _deviceData.entries
                      .map((entry) => _buildInfoRow(context, entry.key, entry.value.toString()))
                      .toList(),
            ),

            const SizedBox(height: 20),

            // About Application Section
            _buildInfoCard(
              context,
              title: 'Tentang Aplikasi',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '''Aplikasi ini adalah sebuah [jelaskan aplikasi Anda, misal: aplikasi manajemen tugas pribadi] yang dirancang untuk membantu Anda [sebutkan tujuan utama, misal: mengatur jadwal harian dan meningkatkan produktivitas].

Fungsi utamanya meliputi [sebutkan fungsi-fungsi utama, misal: membuat daftar tugas, mengatur pengingat, melacak kemajuan proyek]. Manfaat yang Anda dapatkan adalah [sebutkan manfaat, misal: mengurangi stres, memastikan tidak ada tugas yang terlewat, dan mencapai tujuan pribadi dengan lebih efisien].''',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Colors.white.withAlpha(204),
              Colors.blue.shade50.withAlpha(178),
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
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
              ),
              const Divider(color: Colors.deepPurpleAccent, thickness: 1, height: 20),
              ...children,
            ],
          ),
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
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
            softWrap: true,
            ),
          ),
          const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
