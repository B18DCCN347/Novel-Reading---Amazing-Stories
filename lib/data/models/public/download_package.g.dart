// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_package.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadPackageAdapter extends TypeAdapter<DownloadPackage> {
  @override
  final int typeId = 10;

  @override
  DownloadPackage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadPackage(
      id: fields[0] as String?,
      pageIndex: fields[1] as int?,
      pageSize: fields[2] as int?,
      hash: fields[3] as String?,
      createdTs: fields[4] as int?,
      link: fields[5] as String?,
      downloaded: fields[6] as bool?,
      bookId: fields[8] as String?,
      eps: (fields[7] as List?)?.cast<PackageEpisode>(),
    );
  }

  @override
  void write(BinaryWriter writer, DownloadPackage obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pageIndex)
      ..writeByte(2)
      ..write(obj.pageSize)
      ..writeByte(3)
      ..write(obj.hash)
      ..writeByte(4)
      ..write(obj.createdTs)
      ..writeByte(5)
      ..write(obj.link)
      ..writeByte(6)
      ..write(obj.downloaded)
      ..writeByte(7)
      ..write(obj.eps)
      ..writeByte(8)
      ..write(obj.bookId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadPackageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadPackage _$DownloadPackageFromJson(Map<String, dynamic> json) =>
    DownloadPackage(
      id: json['id'] as String?,
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      hash: json['hash'] as String?,
      createdTs: json['createdTs'] as int?,
      link: json['link'] as String?,
      downloaded: json['downloaded'] as bool?,
      bookId: json['bookId'] as String?,
      eps: (json['eps'] as List<dynamic>?)
          ?.map((e) => PackageEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DownloadPackageToJson(DownloadPackage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'hash': instance.hash,
      'createdTs': instance.createdTs,
      'link': instance.link,
      'downloaded': instance.downloaded,
      'eps': instance.eps,
      'bookId': instance.bookId,
    };

DownloadPackageResponse _$DownloadPackageResponseFromJson(
        Map<String, dynamic> json) =>
    DownloadPackageResponse(
      data: json['data'] == null
          ? null
          : DownloadPackage.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$DownloadPackageResponseToJson(
        DownloadPackageResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

DownloadPackageListResponse _$DownloadPackageListResponseFromJson(
        Map<String, dynamic> json) =>
    DownloadPackageListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DownloadPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$DownloadPackageListResponseToJson(
        DownloadPackageListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
