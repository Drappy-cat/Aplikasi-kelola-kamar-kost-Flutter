import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/utils/json_converters.dart'; // <-- IMPORT PENERJEMAH

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String title,
    required String subtitle,
    required DateTime date,
    
    // Menggunakan converter untuk tipe data yang tidak didukung JSON secara default
    @IconDataConverter() required IconData icon,
    @ColorConverter() required Color iconColor,
    
    @Default(false) bool isRead,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}
