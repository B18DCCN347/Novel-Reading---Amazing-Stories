// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_marker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookMarkerAdapter extends TypeAdapter<BookMarker> {
  @override
  final int typeId = 2;

  @override
  BookMarker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookMarker(
      bookId: fields[0] as String,
      chapterId: fields[1] as String,
      position: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BookMarker obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.chapterId)
      ..writeByte(2)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookMarkerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
