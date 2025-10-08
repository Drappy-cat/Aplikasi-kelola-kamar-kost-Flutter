import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converter untuk mengubah IconData menjadi integer (codePoint) dan sebaliknya.
class IconDataConverter implements JsonConverter<IconData, int> {
  const IconDataConverter();

  @override
  IconData fromJson(int json) {
    // Membuat IconData dari codePoint yang tersimpan
    return IconData(json, fontFamily: 'MaterialIcons');
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
