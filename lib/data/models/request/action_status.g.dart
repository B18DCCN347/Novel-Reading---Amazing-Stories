// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionStatusAdapter extends TypeAdapter<ActionStatus> {
  @override
  final int typeId = 8;

  @override
  ActionStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActionStatus(
      success: fields[0] as bool?,
      hasLiked: fields[1] as bool?,
      hasRate: fields[2] as bool?,
      rate: fields[3] as int?,
      hasRead: fields[4] as bool?,
      episodeIndex: fields[5] as int?,
      bookId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ActionStatus obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.hasLiked)
      ..writeByte(2)
      ..write(obj.hasRate)
      ..writeByte(3)
      ..write(obj.rate)
      ..writeByte(4)
      ..write(obj.hasRead)
      ..writeByte(5)
      ..write(obj.episodeIndex)
      ..writeByte(6)
      ..write(obj.bookId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionStatus _$ActionStatusFromJson(Map<String, dynamic> json) => ActionStatus(
      success: json['success'] as bool?,
      hasLiked: json['hasLiked'] as bool?,
      hasRate: json['hasRate'] as bool?,
      rate: json['rate'] as int?,
      hasRead: json['hasRead'] as bool?,
      episodeIndex: json['episodeIndex'] as int?,
      bookId: json['bookId'] as String?,
    );

Map<String, dynamic> _$ActionStatusToJson(ActionStatus instance) =>
    <String, dynamic>{
      'success': instance.success,
      'hasLiked': instance.hasLiked,
      'hasRate': instance.hasRate,
      'rate': instance.rate,
      'hasRead': instance.hasRead,
      'episodeIndex': instance.episodeIndex,
      'bookId': instance.bookId,
    };
