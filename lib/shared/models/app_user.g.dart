// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      fullName: json['fullName'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      roomId: json['roomId'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'role': instance.role,
      'fullName': instance.fullName,
      'profileImageUrl': instance.profileImageUrl,
      'roomId': instance.roomId,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
    };
