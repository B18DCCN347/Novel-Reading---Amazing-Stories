// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewer_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViewerSettingAdapter extends TypeAdapter<ViewerSetting> {
  @override
  final int typeId = 1;

  @override
  ViewerSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViewerSetting(
      font: fields[0] as String,
      size: fields[1] as double,
      currentPage: fields[3] as int,
      theme: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ViewerSetting obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.font)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.theme)
      ..writeByte(3)
      ..write(obj.currentPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewerSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
