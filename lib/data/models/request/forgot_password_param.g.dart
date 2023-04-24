// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordParam _$ForgotPasswordParamFromJson(Map<String, dynamic> json) =>
    ForgotPasswordParam(
      userName: json['user_name'] as String?,
      secretCode: json['secret_code'] as String,
    );

Map<String, dynamic> _$ForgotPasswordParamToJson(
        ForgotPasswordParam instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'secret_code': instance.secretCode,
    };
