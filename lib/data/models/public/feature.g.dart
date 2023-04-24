// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feature _$FeatureFromJson(Map<String, dynamic> json) => Feature(
      feature: json['feature'] as String?,
      times: json['times'] as int?,
      validFrom: json['validFrom'] as int?,
      validThru: json['validThru'] as int?,
    );

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
      'feature': instance.feature,
      'times': instance.times,
      'validFrom': instance.validFrom,
      'validThru': instance.validThru,
    };

FeatureResponse _$FeatureResponseFromJson(Map<String, dynamic> json) =>
    FeatureResponse(
      data: json['data'] == null
          ? null
          : Feature.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$FeatureResponseToJson(FeatureResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

FeatureListResponse _$FeatureListResponseFromJson(Map<String, dynamic> json) =>
    FeatureListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$FeatureListResponseToJson(
        FeatureListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
