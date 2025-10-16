import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// Peta ini penting untuk proses konversi dari integer (codePoint) kembali ke IconData.
// Saat Flutter build untuk web, ia melakukan "tree-shaking" yang agresif dan akan menghapus
// konstanta ikon yang tidak direferensikan secara langsung. Peta ini memastikan
// konstanta ikon yang kita butuhkan tetap disertakan dalam build.
const Map<int, IconData> _iconMap = {
  0xe68d: Icons.waving_hand,
  0xe3b2: Icons.hourglass_top,
  0xe150: Icons.check_circle,
  0xe115: Icons.bookmark_added,
  0xf0832: Icons.history_toggle_off_outlined,
  // Tambahkan ikon lain yang digunakan di notifikasi ke peta ini.
};

/// JsonConverter untuk mengubah objek `IconData` menjadi `int` (codePoint) saat menyimpan ke JSON,
/// dan sebaliknya saat membaca dari JSON.
class IconDataConverter implements JsonConverter<IconData, int> {
  const IconDataConverter();

  /// Mengubah integer dari JSON menjadi objek IconData.
  @override
  IconData fromJson(int json) {
    // Mencari IconData yang sesuai dari peta ikon.
    // Jika tidak ditemukan, kembalikan ikon default untuk menghindari error.
    return _iconMap[json] ?? Icons.help_outline;
  }

  /// Mengubah objek IconData menjadi integer (codePoint) untuk disimpan di JSON.
  @override
  int toJson(IconData object) {
    return object.codePoint;
  }
}

/// JsonConverter untuk mengubah objek `Color` menjadi `int` (value) saat menyimpan ke JSON,
/// dan sebaliknya saat membaca dari JSON.
class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  /// Mengubah integer dari JSON menjadi objek Color.
  @override
  Color fromJson(int json) {
    return Color(json);
  }

  /// Mengubah objek Color menjadi integer (nilainya) untuk disimpan di JSON.
  @override
  int toJson(Color object) {
    return object.value;
  }
}
