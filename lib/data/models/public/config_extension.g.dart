// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_extension.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigExtension _$ConfigExtensionFromJson(Map<String, dynamic> json) =>
    ConfigExtension(
      liveChatSupportUrl: json['liveChatSupportUrl'] as String?,
    );

Map<String, dynamic> _$ConfigExtensionToJson(ConfigExtension instance) =>
    <String, dynamic>{
      'liveChatSupportUrl': instance.liveChatSupportUrl,
    };

ConfigExtensionResponse _$ConfigExtensionResponseFromJson(
        Map<String, dynamic> json) =>
    ConfigExtensionResponse(
      data: json['data'] == null
          ? null
          : ConfigExtension.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ConfigExtensionResponseToJson(
        ConfigExtensionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ConfigExtensionListResponse _$ConfigExtensionListResponseFromJson(
        Map<String, dynamic> json) =>
    ConfigExtensionListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ConfigExtension.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ConfigExtensionListResponseToJson(
        ConfigExtensionListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
