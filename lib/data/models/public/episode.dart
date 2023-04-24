import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'episode.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.chapter)
class Episode extends HiveObject {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? altTitle;
  @HiveField(3)
  int? index;
  @HiveField(4)
  int? price;
  @HiveField(5)
  String? createdDate;
  @HiveField(6)
  String? lastUpdate;
  @HiveField(7)
  bool? purchased;
  @HiveField(8)
  String? bookId;

  Episode({
    this.uuid,
    this.bookId,
    this.title,
    this.altTitle,
    this.index,
    this.createdDate,
    this.lastUpdate,
    this.purchased,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

@JsonSerializable()
class EpisodeResponse extends ResultInfo {
  Episode? data;

  EpisodeResponse({this.data});

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      _$EpisodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeResponseToJson(this);
}

@JsonSerializable()
class EpisodeListResponse extends ResultInfo {
  List<Episode>? data;

  EpisodeListResponse({this.data});

  factory EpisodeListResponse.fromJson(Map<String, dynamic> json) =>
      _$EpisodeListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeListResponseToJson(this);
}
