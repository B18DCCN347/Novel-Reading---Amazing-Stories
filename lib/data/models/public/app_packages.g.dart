// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_packages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPackages _$AppPackagesFromJson(Map<String, dynamic> json) => AppPackages(
      removeAds: (json['remove_ads'] as List<dynamic>?)
          ?.map((e) => InAppProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      wallet: (json['wallet'] as List<dynamic>?)
          ?.map((e) => InAppProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppPackagesToJson(AppPackages instance) =>
    <String, dynamic>{
      'remove_ads': instance.removeAds,
      'wallet': instance.wallet,
    };

AppPackagesResponse _$AppPackagesResponseFromJson(Map<String, dynamic> json) =>
    AppPackagesResponse(
      data: json['data'] == null
          ? null
          : AppPackages.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AppPackagesResponseToJson(
        AppPackagesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

AppPackagesListResponse _$AppPackagesListResponseFromJson(
        Map<String, dynamic> json) =>
    AppPackagesListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AppPackages.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AppPackagesListResponseToJson(
        AppPackagesListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
