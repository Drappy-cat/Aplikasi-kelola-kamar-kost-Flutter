import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// Peta untuk memetakan codePoint kembali ke instance IconData yang konstan.
// Diperlukan agar tree-shaking ikon berfungsi saat build web.
// Tambahkan ikon lain yang digunakan di notifikasi ke peta ini.
const Map<int, IconData> _iconMap = {
  0xe68d: Icons.waving_hand,
  // Tambahkan ikon lain di sini jika diperlukan, contoh:
  // 0xe318: Icons.info,
};

/// Converter untuk mengubah IconData menjadi integer (codePoint) dan sebaliknya.
class IconDataConverter implements JsonConverter<IconData, int> {
  const IconDataConverter();

  @override
  IconData fromJson(int json) {
    // Mencari IconData konstan dari peta.
    // Mengembalikan ikon default jika tidak ditemukan.
    return _iconMap[json] ?? Icons.help_outline;
  }

  @override
  int toJson(IconData object) {
    // Menyimpan codePoint dari IconData sebagai integer
    return object.codePoint;
  }
}

/// Converter untuk mengubah Color menjadi integer (value) dan sebaliknya.
class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) {
    // Membuat Color dari nilai integer yang tersimpan
    return Color(json);
  }

  @override
  int toJson(Color object) {
    // Menyimpan nilai integer dari Color
    return object.value;
  }
}
