// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_episode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageEpisodeAdapter extends TypeAdapter<PackageEpisode> {
  @override
  final int typeId = 11;

  @override
  PackageEpisode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageEpisode(
      uuid: fields[0] as String?,
      title: fields[1] as String?,
      index: fields[2] as int?,
      createdDate: fields[3] as String?,
      lastUpdate: fields[4] as String?,
      html: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PackageEpisode obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.createdDate)
      ..writeByte(4)
      ..write(obj.lastUpdate)
      ..writeByte(5)
      ..write(obj.html);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageEpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageEpisode _$PackageEpisodeFromJson(Map<String, dynamic> json) =>
    PackageEpisode(
      uuid: json['uuid'] as String?,
      title: json['title'] as String?,
      index: json['index'] as int?,
      createdDate: json['createdDate'] as String?,
      lastUpdate: json['lastUpdate'] as String?,
      html: json['html'] as String?,
    );

Map<String, dynamic> _$PackageEpisodeToJson(PackageEpisode instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'index': instance.index,
      'createdDate': instance.createdDate,
      'lastUpdate': instance.lastUpdate,
      'html': instance.html,
    };

PackageEpisodeResponse _$PackageEpisodeResponseFromJson(
        Map<String, dynamic> json) =>
    PackageEpisodeResponse(
      data: json['data'] == null
          ? null
          : PackageEpisode.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PackageEpisodeResponseToJson(
        PackageEpisodeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

PackageEpisodeListResponse _$PackageEpisodeListResponseFromJson(
        Map<String, dynamic> json) =>
    PackageEpisodeListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PackageEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PackageEpisodeListResponseToJson(
        PackageEpisodeListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
