// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapters_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChaptersResponse _$ChaptersResponseFromJson(Map<String, dynamic> json) =>
    ChaptersResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNext: json['hasNext'] as bool?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$ChaptersResponseToJson(ChaptersResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'hasNext': instance.hasNext,
      'success': instance.success,
    };
