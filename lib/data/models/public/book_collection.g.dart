// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookCollection _$BookCollectionFromJson(Map<String, dynamic> json) =>
    BookCollection(
      codeName: json['codeName'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookCollectionToJson(BookCollection instance) =>
    <String, dynamic>{
      'codeName': instance.codeName,
      'title': instance.title,
      'type': instance.type,
      'items': instance.items,
    };

BookCollectionResponse _$BookCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    BookCollectionResponse(
      data: json['data'] == null
          ? null
          : BookCollection.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BookCollectionResponseToJson(
        BookCollectionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

BookCollectionListResponse _$BookCollectionListResponseFromJson(
        Map<String, dynamic> json) =>
    BookCollectionListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookCollection.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BookCollectionListResponseToJson(
        BookCollectionListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
