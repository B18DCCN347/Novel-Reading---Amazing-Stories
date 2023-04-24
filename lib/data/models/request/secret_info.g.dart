// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecretInfo _$SecretInfoFromJson(Map<String, dynamic> json) => SecretInfo(
      userName: json['username'] as String,
      password: json['password'] as String,
      grantType: json['grant_type'] as String,
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
    );

Map<String, dynamic> _$SecretInfoToJson(SecretInfo instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'username': instance.userName,
      'password': instance.password,
    };
