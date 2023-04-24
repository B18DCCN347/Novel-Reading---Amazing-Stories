// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => AuthResult(
      uuid: json['uuid'] as String?,
      token: json['token'] as String?,
      authProvider: json['authProvider'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$AuthResultToJson(AuthResult instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'token': instance.token,
      'authProvider': instance.authProvider,
      'success': instance.success,
    };
