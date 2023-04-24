// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_token_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateTokenResult _$ValidateTokenResultFromJson(Map<String, dynamic> json) =>
    ValidateTokenResult(
      success: json['success'] as bool?,
    )..customer = json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>);

Map<String, dynamic> _$ValidateTokenResultToJson(
        ValidateTokenResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'customer': instance.customer,
    };
