import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'package_episode.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.packageEpisode)
class PackageEpisode extends HiveObject {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  String? title;
  @HiveField(2)
  int? index;
  @HiveField(3)
  String? createdDate;
  @HiveField(4)
  String? lastUpdate;
  @HiveField(5)
  String? html;

  PackageEpisode({
    this.uuid,
    this.title,
    this.index,
    this.createdDate,
    this.lastUpdate,
    this.html,
  });
  PackageEpisode clone() {
    return PackageEpisode(
      uuid: this.uuid,
      title: this.title,
      index: this.index,
      createdDate: this.createdDate,
      lastUpdate: this.lastUpdate,
      html: this.html,
    );
  }

  factory PackageEpisode.fromJson(Map<String, dynamic> json) =>
      _$PackageEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$PackageEpisodeToJson(this);
}

@JsonSerializable()
class PackageEpisodeResponse extends ResultInfo {
  PackageEpisode? data;

  PackageEpisodeResponse({this.data});

  factory PackageEpisodeResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageEpisodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PackageEpisodeResponseToJson(this);
}

@JsonSerializable()
class PackageEpisodeListResponse extends ResultInfo {
  List<PackageEpisode>? data;

  PackageEpisodeListResponse({this.data});

  factory PackageEpisodeListResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageEpisodeListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PackageEpisodeListResponseToJson(this);
}
