import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_cache.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.appCache)
class AppCache extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime time;

  AppCache({
    this.id,
    required this.name,
    this.description = "",
    required this.time,
  });

  factory AppCache.fromJson(Map<String, dynamic> json) =>
      _$AppCacheFromJson(json);

  Map<String, dynamic> toJson() => _$AppCacheToJson(this);
}

@JsonSerializable()
class AppCacheResponse extends ResultInfo {
  AppCache? data;

  AppCacheResponse({this.data});

  factory AppCacheResponse.fromJson(Map<String, dynamic> json) =>
      _$AppCacheResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppCacheResponseToJson(this);
}

@JsonSerializable()
class AppCacheListResponse extends ResultInfo {
  List<AppCache>? data;

  AppCacheListResponse({this.data});

  factory AppCacheListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppCacheListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppCacheListResponseToJson(this);
}
