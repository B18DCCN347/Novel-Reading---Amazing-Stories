// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterDataAdapter extends TypeAdapter<ChapterData> {
  @override
  final int typeId = 4;

  @override
  ChapterData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChapterData(
      bookId: fields[1] as String,
      chapterId: fields[2] as String,
      data: fields[3] as String,
      time: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChapterData obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.bookId)
      ..writeByte(2)
      ..write(obj.chapterId)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterData _$ChapterDataFromJson(Map<String, dynamic> json) => ChapterData(
      bookId: json['bookId'] as String,
      chapterId: json['chapterId'] as String,
      data: json['data'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$ChapterDataToJson(ChapterData instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'chapterId': instance.chapterId,
      'data': instance.data,
      'time': instance.time.toIso8601String(),
    };

ChapterDataResponse _$ChapterDataResponseFromJson(Map<String, dynamic> json) =>
    ChapterDataResponse(
      data: json['data'] == null
          ? null
          : ChapterData.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ChapterDataResponseToJson(
        ChapterDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ChapterDataListResponse _$ChapterDataListResponseFromJson(
        Map<String, dynamic> json) =>
    ChapterDataListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ChapterData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ChapterDataListResponseToJson(
        ChapterDataListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
