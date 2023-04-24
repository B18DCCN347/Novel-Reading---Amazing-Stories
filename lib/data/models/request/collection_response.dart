import 'package:json_annotation/json_annotation.dart';
import 'package:love_novel/data/models/public/book.dart';

part 'collection_response.g.dart';

@JsonSerializable()
class CollectionResponse {
  List<Book>? data;
  bool? hasNext;
  bool? success;
  CollectionResponse({
    this.data,
    this.hasNext,
    this.success,
  });
  factory CollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionResponseToJson(this);
}
