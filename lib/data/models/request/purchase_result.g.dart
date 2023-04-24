// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseResult _$PurchaseResultFromJson(Map<String, dynamic> json) =>
    PurchaseResult(
      transErrorCode: json['transErrorCode'] as int?,
      transStatus: json['transStatus'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$PurchaseResultToJson(PurchaseResult instance) =>
    <String, dynamic>{
      'transErrorCode': instance.transErrorCode,
      'transStatus': instance.transStatus,
      'success': instance.success,
    };
