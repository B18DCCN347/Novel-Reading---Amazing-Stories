// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      contentCategory: (json['contentCategory'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      iap: (json['iap'] as List<dynamic>?)
          ?.map((e) => InAppProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      iapPackages: (json['iapPackages'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => InAppProduct.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      apiSettings: json['apiSettings'] == null
          ? null
          : ApiSettings.fromJson(json['apiSettings'] as Map<String, dynamic>),
      ext: json['ext'] == null
          ? null
          : ConfigExtension.fromJson(json['ext'] as Map<String, dynamic>),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'contentCategory': instance.contentCategory,
      'iap': instance.iap,
      'iapPackages': instance.iapPackages,
      'apiSettings': instance.apiSettings,
      'success': instance.success,
      'ext': instance.ext,
    };

AppConfigResponse _$AppConfigResponseFromJson(Map<String, dynamic> json) =>
    AppConfigResponse(
      data: json['data'] == null
          ? null
          : AppConfig.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AppConfigResponseToJson(AppConfigResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

AppConfigListResponse _$AppConfigListResponseFromJson(
        Map<String, dynamic> json) =>
    AppConfigListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AppConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AppConfigListResponseToJson(
        AppConfigListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
