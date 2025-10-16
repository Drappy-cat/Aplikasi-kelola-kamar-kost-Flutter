// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  code: json['code'] as String,
  status: json['status'] as String,
  dimensions: json['dimensions'] as String? ?? 'N/A',
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  baseRent: (json['baseRent'] as num).toInt(),
  wifi: (json['wifi'] as num).toInt(),
  water: (json['water'] as num).toInt(),
  electricity: (json['electricity'] as num).toInt(),
  acCost: (json['acCost'] as num?)?.toInt() ?? 0,
  packageFull: json['packageFull'] as bool? ?? false,
  isFurnished: json['isFurnished'] as bool? ?? false,
  jumlahKasur: (json['jumlahKasur'] as num?)?.toInt() ?? 1,
  fasilitasTambahan: json['fasilitasTambahan'] as String?,
  tenantName: json['tenantName'] as String?,
  tenantAddress: json['tenantAddress'] as String?,
  tenantPhone: json['tenantPhone'] as String?,
  rentStartDate: json['rentStartDate'] as String?,
);

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'dimensions': instance.dimensions,
      'imageUrls': instance.imageUrls,
      'baseRent': instance.baseRent,
      'wifi': instance.wifi,
      'water': instance.water,
      'electricity': instance.electricity,
      'acCost': instance.acCost,
      'packageFull': instance.packageFull,
      'isFurnished': instance.isFurnished,
      'jumlahKasur': instance.jumlahKasur,
      'fasilitasTambahan': instance.fasilitasTambahan,
      'tenantName': instance.tenantName,
      'tenantAddress': instance.tenantAddress,
      'tenantPhone': instance.tenantPhone,
      'rentStartDate': instance.rentStartDate,
    };
