import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.category)
class Category extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? thumb;
  @HiveField(3)
  int? nContents;

  Category({
    this.id,
    this.name = "",
    this.thumb = "",
    this.nContents,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class CategoryResponse extends ResultInfo {
  Category? data;

  CategoryResponse({this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategoryListResponse extends ResultInfo {
  List<Category>? data;

  CategoryListResponse({this.data});

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListResponseToJson(this);
}
