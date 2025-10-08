// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationImpl(
  title: json['title'] as String,
  subtitle: json['subtitle'] as String,
  date: DateTime.parse(json['date'] as String),
  icon: const IconDataConverter().fromJson((json['icon'] as num).toInt()),
  iconColor: const ColorConverter().fromJson(
    (json['iconColor'] as num).toInt(),
  ),
  isRead: json['isRead'] as bool? ?? false,
);

Map<String, dynamic> _$$AppNotificationImplToJson(
  _$AppNotificationImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'subtitle': instance.subtitle,
  'date': instance.date.toIso8601String(),
  'icon': const IconDataConverter().toJson(instance.icon),
  'iconColor': const ColorConverter().toJson(instance.iconColor),
  'isRead': instance.isRead,
};
