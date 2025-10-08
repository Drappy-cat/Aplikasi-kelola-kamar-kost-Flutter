// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComplaintImpl _$$ComplaintImplFromJson(Map<String, dynamic> json) =>
    _$ComplaintImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      roomId: json['roomId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ComplaintImplToJson(_$ComplaintImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'roomId': instance.roomId,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'status': instance.status,
      'imageUrls': instance.imageUrls,
      'createdAt': instance.createdAt.toIso8601String(),
    };
