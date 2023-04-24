// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatAdapter extends TypeAdapter<Stat> {
  @override
  final int typeId = 9;

  @override
  Stat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stat(
      contentId: fields[0] as int?,
      like: fields[1] as int?,
      rate: fields[2] as double?,
      rateBy: fields[3] as int?,
      read: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Stat obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.contentId)
      ..writeByte(1)
      ..write(obj.like)
      ..writeByte(2)
      ..write(obj.rate)
      ..writeByte(3)
      ..write(obj.rateBy)
      ..writeByte(4)
      ..write(obj.read);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stat _$StatFromJson(Map<String, dynamic> json) => Stat(
      contentId: json['contentId'] as int?,
      like: json['like'] as int?,
      rate: (json['rate'] as num?)?.toDouble(),
      rateBy: json['rateBy'] as int?,
      read: json['read'] as int?,
    );

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'contentId': instance.contentId,
      'like': instance.like,
      'rate': instance.rate,
      'rateBy': instance.rateBy,
      'read': instance.read,
    };

StatResponse _$StatResponseFromJson(Map<String, dynamic> json) => StatResponse(
      data: json['data'] == null
          ? null
          : Stat.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$StatResponseToJson(StatResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

StatListResponse _$StatListResponseFromJson(Map<String, dynamic> json) =>
    StatListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Stat.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$StatListResponseToJson(StatListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
