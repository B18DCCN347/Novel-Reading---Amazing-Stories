// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultInfo _$ResultInfoFromJson(Map<String, dynamic> json) => ResultInfo(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResultInfoToJson(ResultInfo instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

RestStringData _$RestStringDataFromJson(Map<String, dynamic> json) =>
    RestStringData(
      success: json['success'] as bool?,
      data: json['data'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestStringDataToJson(RestStringData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'errors': instance.errors,
    };

RestNumberData _$RestNumberDataFromJson(Map<String, dynamic> json) =>
    RestNumberData(
      success: json['success'] as bool?,
      data: (json['data'] as num?)?.toDouble(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestNumberDataToJson(RestNumberData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'errors': instance.errors,
    };

RestErrorDetail _$RestErrorDetailFromJson(Map<String, dynamic> json) =>
    RestErrorDetail(
      code: json['code'] as int?,
      message: json['message'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$RestErrorDetailToJson(RestErrorDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'type': instance.type,
      'message': instance.message,
    };
