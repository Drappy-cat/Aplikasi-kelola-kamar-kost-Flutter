import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key});

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  late Future<Map<String, String>> _deviceInfoFuture;

  @override
  void initState() {
    super.initState();
    _deviceInfoFuture = _getDeviceInfo();
  }

  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final Map<String, String> data = {};
    try {
      if (kIsWeb) {
        final webInfo = await deviceInfoPlugin.webBrowserInfo;
        data.addAll({
          'Platform': 'Web',
          'Browser': webInfo.browserName.name,
          'User Agent': webInfo.userAgent ?? 'N/A',
        });
      } else if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        data.addAll({
          'Perangkat': '${androidInfo.brand} ${androidInfo.model}',
          'Sistem Operasi': 'Android ${androidInfo.version.release}',
          'SDK': '${androidInfo.version.sdkInt}',
          'Tipe': androidInfo.isPhysicalDevice ? 'Fisik' : 'Emulator',
        });
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        data.addAll({
          'Perangkat': iosInfo.name,
          'Model': iosInfo.model ?? 'N/A',
          'Sistem Operasi': '${iosInfo.systemName} ${iosInfo.systemVersion}',
          'Tipe': iosInfo.isPhysicalDevice ? 'Fisik' : 'Simulator',
        });
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfoPlugin.windowsInfo;
        data.addAll({
          'Platform': 'Windows',
          'Nama Komputer': windowsInfo.computerName,
          'Versi': windowsInfo.displayVersion,
          'Build': '${windowsInfo.buildNumber}',
        });
      }
    } catch (e) {
      data['Error'] = e.toString();
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Perangkat'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _deviceInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Padding(padding: const EdgeInsets.all(16.0), child: Text('Terjadi Error: ${snapshot.error}')));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada informasi perangkat yang bisa ditampilkan.'));
          }
          final deviceData = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: deviceData.entries.map((entry) {
              return ListTile(
                title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(entry.value),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
