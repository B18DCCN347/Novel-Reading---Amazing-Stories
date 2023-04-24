// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppCacheAdapter extends TypeAdapter<AppCache> {
  @override
  final int typeId = 3;

  @override
  AppCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppCache(
      id: fields[0] as int?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      time: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AppCache obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppCache _$AppCacheFromJson(Map<String, dynamic> json) => AppCache(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String? ?? "",
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$AppCacheToJson(AppCache instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'time': instance.time.toIso8601String(),
    };

AppCacheResponse _$AppCacheResponseFromJson(Map<String, dynamic> json) =>
    AppCacheResponse(
      data: json['data'] == null
          ? null
          : AppCache.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AppCacheResponseToJson(AppCacheResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

AppCacheListResponse _$AppCacheListResponseFromJson(
        Map<String, dynamic> json) =>
    AppCacheListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AppCache.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AppCacheListResponseToJson(
        AppCacheListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
