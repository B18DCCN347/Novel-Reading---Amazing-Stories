// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSettings _$ApiSettingsFromJson(Map<String, dynamic> json) => ApiSettings(
      bannerAdsOrder: (json['bannerAdsOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fullscreenAdsCap: json['fullscreenAdsCap'] == null
          ? null
          : FullscreenAdsCap.fromJson(
              json['fullscreenAdsCap'] as Map<String, dynamic>),
      noAds: json['noAds'] as bool?,
      noAdsFirstNDays: json['noAdsFirstNDays'] as int?,
    );

Map<String, dynamic> _$ApiSettingsToJson(ApiSettings instance) =>
    <String, dynamic>{
      'bannerAdsOrder': instance.bannerAdsOrder,
      'fullscreenAdsCap': instance.fullscreenAdsCap,
      'noAds': instance.noAds,
      'noAdsFirstNDays': instance.noAdsFirstNDays,
    };

ApiSettingsResponse _$ApiSettingsResponseFromJson(Map<String, dynamic> json) =>
    ApiSettingsResponse(
      data: json['data'] == null
          ? null
          : ApiSettings.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ApiSettingsResponseToJson(
        ApiSettingsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ApiSettingsListResponse _$ApiSettingsListResponseFromJson(
        Map<String, dynamic> json) =>
    ApiSettingsListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ApiSettings.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ApiSettingsListResponseToJson(
        ApiSettingsListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
