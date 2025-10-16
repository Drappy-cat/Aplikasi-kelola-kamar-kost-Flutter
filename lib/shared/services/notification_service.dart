import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service ini bertanggung jawab untuk menampilkan notifikasi lokal di perangkat (simulasi push notification).
/// Menggunakan package `flutter_local_notifications`.
class NotificationService {
  // Instance dari plugin notifikasi yang akan digunakan untuk semua operasi notifikasi.
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Inisialisasi service. Wajib dipanggil saat aplikasi dimulai.
  Future<void> init() async {
    // Pengaturan inisialisasi spesifik untuk platform Android.
    // 'mipmap/ic_launcher' adalah path default untuk ikon aplikasi Android yang akan ditampilkan di notifikasi.
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    // Pengaturan inisialisasi spesifik untuk platform iOS.
    // Meminta izin dari pengguna untuk menampilkan notifikasi, badge, dan suara.
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Menggabungkan pengaturan dari kedua platform.
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Lakukan inisialisasi plugin dengan pengaturan yang telah dibuat.
    await _notificationsPlugin.initialize(initializationSettings);
  }

  /// Menampilkan notifikasi sederhana di perangkat.
  Future<void> showNotification(String title, String body) async {
    // Detail notifikasi spesifik untuk Android, termasuk channel.
    // Channel wajib untuk Android 8.0 (API level 26) ke atas.
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'ri_kost_channel_id', // ID unik untuk channel notifikasi Anda.
      'Notifikasi Umum', // Nama channel yang akan terlihat di pengaturan notifikasi Android.
      channelDescription: 'Channel untuk notifikasi umum dari aplikasi Ri-Kost.', // Deskripsi channel.
      importance: Importance.max, // Prioritas tertinggi untuk memastikan notifikasi muncul di atas.
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      // Pengaturan iOS bisa ditambahkan di sini jika perlu kustomisasi lebih lanjut.
    );

    // Tampilkan notifikasi dengan ID, judul, isi, dan detail yang telah ditentukan.
    await _notificationsPlugin.show(
      0, // ID notifikasi. Menggunakan ID yang sama akan menimpa notifikasi sebelumnya.
      title,
      body,
      notificationDetails,
    );
  }
}
