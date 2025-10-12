// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestImpl _$$RequestImplFromJson(Map<String, dynamic> json) =>
    _$RequestImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      date: json['date'] as String,
      note: json['note'] as String,
      status: json['status'] as String,
      roomCode: json['roomCode'] as String?,
      userName: json['userName'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentDueDate: json['paymentDueDate'] == null
          ? null
          : DateTime.parse(json['paymentDueDate'] as String),
      virtualAccountNumber: json['virtualAccountNumber'] as String?,
    );

Map<String, dynamic> _$$RequestImplToJson(_$RequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'date': instance.date,
      'note': instance.note,
      'status': instance.status,
      'roomCode': instance.roomCode,
      'userName': instance.userName,
      'paymentMethod': instance.paymentMethod,
      'paymentDueDate': instance.paymentDueDate?.toIso8601String(),
      'virtualAccountNumber': instance.virtualAccountNumber,
    };
