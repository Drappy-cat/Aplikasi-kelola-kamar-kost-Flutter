// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillImpl _$$BillImplFromJson(Map<String, dynamic> json) => _$BillImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  roomId: json['roomId'] as String,
  period: json['period'] as String,
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String,
  paymentProofUrl: json['paymentProofUrl'] as String?,
  paymentMethod: json['paymentMethod'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$BillImplToJson(_$BillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'roomId': instance.roomId,
      'period': instance.period,
      'amount': instance.amount,
      'status': instance.status,
      'paymentProofUrl': instance.paymentProofUrl,
      'paymentMethod': instance.paymentMethod,
      'createdAt': instance.createdAt.toIso8601String(),
    };
