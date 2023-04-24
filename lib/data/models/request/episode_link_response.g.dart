// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_link_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeLinkResponse _$EpisodeLinkResponseFromJson(Map<String, dynamic> json) =>
    EpisodeLinkResponse(
      link: json['link'] as String?,
      status: json['status'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$EpisodeLinkResponseToJson(
        EpisodeLinkResponse instance) =>
    <String, dynamic>{
      'link': instance.link,
      'status': instance.status,
      'success': instance.success,
    };
