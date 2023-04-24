import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book_collection.g.dart';

@JsonSerializable()
class BookCollection {
  String? codeName;
  String? title;
  String? type;
  List<Book>? items;

  BookCollection({
    this.codeName,
    this.title,
    this.type,
    this.items,
  });

  factory BookCollection.fromJson(Map<String, dynamic> json) =>
      _$BookCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BookCollectionToJson(this);
}

@JsonSerializable()
class BookCollectionResponse extends ResultInfo {
  BookCollection? data;

  BookCollectionResponse({this.data});

  factory BookCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$BookCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookCollectionResponseToJson(this);
}

@JsonSerializable()
class BookCollectionListResponse extends ResultInfo {
  List<BookCollection>? data;

  BookCollectionListResponse({this.data});

  factory BookCollectionListResponse.fromJson(Map<String, dynamic> json) =>
      _$BookCollectionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookCollectionListResponseToJson(this);
}
