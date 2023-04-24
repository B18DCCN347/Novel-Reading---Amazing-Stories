// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 5;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      uuid: fields[0] as String?,
      type: fields[1] as int?,
      lang: fields[2] as String?,
      mainCategory: fields[3] as int?,
      sub1Category: fields[4] as int?,
      sub2Category: fields[5] as int?,
      sub3Category: fields[6] as int?,
      category: (fields[7] as List?)?.cast<int>(),
      categories: (fields[8] as List?)?.cast<Category>(),
      title: fields[9] as String?,
      author: fields[10] as String?,
      description: fields[11] as String?,
      portraitThumb: fields[12] as String?,
      featureImage: fields[13] as String?,
      isEnded: fields[14] as int?,
      createdDate: fields[15] as String?,
      lastUpdate: fields[16] as String?,
      active: fields[17] as int?,
      totalEpisodes: fields[18] as int?,
      episodes: (fields[19] as List?)?.cast<Episode>(),
      stats: fields[20] as Stat?,
      promotion: fields[21] as int?,
      cached: fields[22] as bool?,
      read: fields[23] as bool?,
      liked: fields[24] as bool?,
      downloaded: fields[25] as bool?,
      discovery: fields[29] as bool?,
      hot: fields[27] as bool?,
      newUpdated: fields[28] as bool?,
      completed: fields[26] as bool?,
      order: fields[30] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(31)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.lang)
      ..writeByte(3)
      ..write(obj.mainCategory)
      ..writeByte(4)
      ..write(obj.sub1Category)
      ..writeByte(5)
      ..write(obj.sub2Category)
      ..writeByte(6)
      ..write(obj.sub3Category)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.categories)
      ..writeByte(9)
      ..write(obj.title)
      ..writeByte(10)
      ..write(obj.author)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.portraitThumb)
      ..writeByte(13)
      ..write(obj.featureImage)
      ..writeByte(14)
      ..write(obj.isEnded)
      ..writeByte(15)
      ..write(obj.createdDate)
      ..writeByte(16)
      ..write(obj.lastUpdate)
      ..writeByte(17)
      ..write(obj.active)
      ..writeByte(18)
      ..write(obj.totalEpisodes)
      ..writeByte(19)
      ..write(obj.episodes)
      ..writeByte(20)
      ..write(obj.stats)
      ..writeByte(21)
      ..write(obj.promotion)
      ..writeByte(22)
      ..write(obj.cached)
      ..writeByte(23)
      ..write(obj.read)
      ..writeByte(24)
      ..write(obj.liked)
      ..writeByte(25)
      ..write(obj.downloaded)
      ..writeByte(26)
      ..write(obj.completed)
      ..writeByte(27)
      ..write(obj.hot)
      ..writeByte(28)
      ..write(obj.newUpdated)
      ..writeByte(29)
      ..write(obj.discovery)
      ..writeByte(30)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      uuid: json['uuid'] as String?,
      type: json['type'] as int?,
      lang: json['lang'] as String?,
      mainCategory: json['mainCategory'] as int?,
      sub1Category: json['sub1Category'] as int?,
      sub2Category: json['sub2Category'] as int?,
      sub3Category: json['sub3Category'] as int?,
      category:
          (json['category'] as List<dynamic>?)?.map((e) => e as int).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      portraitThumb: json['portraitThumb'] as String?,
      featureImage: json['featureImage'] as String?,
      isEnded: json['isEnded'] as int?,
      createdDate: json['createdDate'] as String?,
      lastUpdate: json['lastUpdate'] as String?,
      active: json['active'] as int?,
      totalEpisodes: json['totalEpisodes'] as int?,
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: json['stats'] == null
          ? null
          : Stat.fromJson(json['stats'] as Map<String, dynamic>),
      promotion: json['promotion'] as int?,
      cached: json['cached'] as bool?,
      read: json['read'] as bool?,
      liked: json['liked'] as bool?,
      downloaded: json['downloaded'] as bool?,
      discovery: json['discovery'] as bool?,
      hot: json['hot'] as bool?,
      newUpdated: json['newUpdated'] as bool?,
      completed: json['completed'] as bool?,
      order: json['order'] as int?,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'type': instance.type,
      'lang': instance.lang,
      'mainCategory': instance.mainCategory,
      'sub1Category': instance.sub1Category,
      'sub2Category': instance.sub2Category,
      'sub3Category': instance.sub3Category,
      'category': instance.category,
      'categories': instance.categories,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'portraitThumb': instance.portraitThumb,
      'featureImage': instance.featureImage,
      'isEnded': instance.isEnded,
      'createdDate': instance.createdDate,
      'lastUpdate': instance.lastUpdate,
      'active': instance.active,
      'totalEpisodes': instance.totalEpisodes,
      'episodes': instance.episodes,
      'stats': instance.stats,
      'promotion': instance.promotion,
      'cached': instance.cached,
      'read': instance.read,
      'liked': instance.liked,
      'downloaded': instance.downloaded,
      'completed': instance.completed,
      'hot': instance.hot,
      'newUpdated': instance.newUpdated,
      'discovery': instance.discovery,
      'order': instance.order,
    };

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) => BookResponse(
      data: json['data'] == null
          ? null
          : Book.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BookResponseToJson(BookResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

BookListResponse _$BookListResponseFromJson(Map<String, dynamic> json) =>
    BookListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$BookListResponseToJson(BookListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
