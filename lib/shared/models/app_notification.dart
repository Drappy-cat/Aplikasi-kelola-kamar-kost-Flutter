import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/utils/json_converters.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// Model data untuk merepresentasikan satu notifikasi yang ditampilkan di dalam aplikasi.
@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    // Judul notifikasi.
    required String title,
    // Isi atau deskripsi singkat dari notifikasi.
    required String subtitle,
    // Tanggal kapan notifikasi ini dibuat.
    required DateTime date,

    // Karena `IconData` dan `Color` bukan tipe data standar JSON,
    // kita memerlukan converter kustom untuk mengubahnya menjadi tipe data primitif (int)
    // saat menyimpan ke SharedPreferences, dan sebaliknya.

    // Menggunakan converter untuk mengubah IconData menjadi integer (codePoint) dan sebaliknya.
    @IconDataConverter() required IconData icon,
    // Menggunakan converter untuk mengubah Color menjadi integer (value) dan sebaliknya.
    @ColorConverter() required Color iconColor,

    // Menandakan apakah notifikasi ini sudah dibaca oleh pengguna.
    @Default(false) bool isRead,
  }) = _AppNotification;

  /// Factory constructor untuk membuat instance AppNotification dari JSON.
  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}
