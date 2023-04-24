// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fullscreen_ads_cap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullscreenAdsCap _$FullscreenAdsCapFromJson(Map<String, dynamic> json) =>
    FullscreenAdsCap(
      minChapter: json['minChapter'] as int?,
      minAdGapInSec: json['minAdGapInSec'] as int?,
      periodicGapInSec: json['periodicGapInSec'] as int?,
      videoInterstitialAlternative:
          json['videoInterstitialAlternative'] as bool?,
    );

Map<String, dynamic> _$FullscreenAdsCapToJson(FullscreenAdsCap instance) =>
    <String, dynamic>{
      'minChapter': instance.minChapter,
      'minAdGapInSec': instance.minAdGapInSec,
      'periodicGapInSec': instance.periodicGapInSec,
      'videoInterstitialAlternative': instance.videoInterstitialAlternative,
    };

FullscreenAdsCapResponse _$FullscreenAdsCapResponseFromJson(
        Map<String, dynamic> json) =>
    FullscreenAdsCapResponse(
      data: json['data'] == null
          ? null
          : FullscreenAdsCap.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$FullscreenAdsCapResponseToJson(
        FullscreenAdsCapResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

FullscreenAdsCapListResponse _$FullscreenAdsCapListResponseFromJson(
        Map<String, dynamic> json) =>
    FullscreenAdsCapListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FullscreenAdsCap.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$FullscreenAdsCapListResponseToJson(
        FullscreenAdsCapListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
