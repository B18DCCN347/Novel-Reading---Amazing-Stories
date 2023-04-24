// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeAdapter extends TypeAdapter<Episode> {
  @override
  final int typeId = 6;

  @override
  Episode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Episode(
      uuid: fields[0] as String?,
      bookId: fields[8] as String?,
      title: fields[1] as String?,
      altTitle: fields[2] as String?,
      index: fields[3] as int?,
      createdDate: fields[5] as String?,
      lastUpdate: fields[6] as String?,
      purchased: fields[7] as bool?,
    )..price = fields[4] as int?;
  }

  @override
  void write(BinaryWriter writer, Episode obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.altTitle)
      ..writeByte(3)
      ..write(obj.index)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.createdDate)
      ..writeByte(6)
      ..write(obj.lastUpdate)
      ..writeByte(7)
      ..write(obj.purchased)
      ..writeByte(8)
      ..write(obj.bookId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      uuid: json['uuid'] as String?,
      bookId: json['bookId'] as String?,
      title: json['title'] as String?,
      altTitle: json['altTitle'] as String?,
      index: json['index'] as int?,
      createdDate: json['createdDate'] as String?,
      lastUpdate: json['lastUpdate'] as String?,
      purchased: json['purchased'] as bool?,
    )..price = json['price'] as int?;

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'altTitle': instance.altTitle,
      'index': instance.index,
      'price': instance.price,
      'createdDate': instance.createdDate,
      'lastUpdate': instance.lastUpdate,
      'purchased': instance.purchased,
      'bookId': instance.bookId,
    };

EpisodeResponse _$EpisodeResponseFromJson(Map<String, dynamic> json) =>
    EpisodeResponse(
      data: json['data'] == null
          ? null
          : Episode.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$EpisodeResponseToJson(EpisodeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

EpisodeListResponse _$EpisodeListResponseFromJson(Map<String, dynamic> json) =>
    EpisodeListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$EpisodeListResponseToJson(
        EpisodeListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
