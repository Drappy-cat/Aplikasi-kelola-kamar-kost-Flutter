import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
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
        data.addAll({'Platform': 'Web', 'Browser': webInfo.browserName.name});
      } else if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        data.addAll({
          'Perangkat': '${androidInfo.brand.toUpperCase()} ${androidInfo.model}',
          'Sistem Operasi': 'Android ${androidInfo.version.release}',
        });
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        data.addAll({
          'Perangkat': iosInfo.name ?? 'N/A',
          'Sistem Operasi': '${iosInfo.systemName} ${iosInfo.systemVersion}',
        });
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfoPlugin.windowsInfo;
        data.addAll({
          'Platform': 'Windows',
          'Nama Komputer': windowsInfo.computerName,
          'Versi': windowsInfo.displayVersion,
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
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Padding(padding: const EdgeInsets.all(16.0), child: Text('Error: ${snapshot.error ?? 'Tidak dapat memuat info perangkat.'}')));
          }
          final deviceData = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: deviceData.length,
            itemBuilder: (context, index) {
              final entry = deviceData.entries.elementAt(index);
              return ListTile(
                title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(entry.value),
              );
            },
            separatorBuilder: (context, index) => const Divider(indent: 16, endIndent: 16),
          );
        },
      ),
    );
  }
}
