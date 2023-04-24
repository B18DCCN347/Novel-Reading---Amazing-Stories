// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordParam _$ChangePasswordParamFromJson(Map<String, dynamic> json) =>
    ChangePasswordParam(
      userName: json['user_name'] as String?,
      secretCode: json['secret_code'] as String?,
      newPassword: json['new_password'] as String?,
    );

Map<String, dynamic> _$ChangePasswordParamToJson(
        ChangePasswordParam instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'secret_code': instance.secretCode,
      'new_password': instance.newPassword,
    };
