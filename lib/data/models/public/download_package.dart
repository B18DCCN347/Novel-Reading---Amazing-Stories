import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/public/package_episode.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'download_package.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.downloadPackage)
class DownloadPackage extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  int? pageIndex;
  @HiveField(2)
  int? pageSize;
  @HiveField(3)
  String? hash;
  @HiveField(4)
  int? createdTs;
  @HiveField(5)
  String? link;
  @HiveField(6)
  bool? downloaded;
  @HiveField(7)
  List<PackageEpisode>? eps;
  @HiveField(8)
  String? bookId;

  DownloadPackage(
      {this.id,
      this.pageIndex,
      this.pageSize,
      this.hash,
      this.createdTs,
      this.link,
      this.downloaded,
      this.bookId,
      this.eps});
  DownloadPackage clone() {
    return DownloadPackage(
      id: this.id,
      pageIndex: this.pageIndex,
      pageSize: this.pageSize,
      hash: this.hash,
      createdTs: this.createdTs,
      link: this.link,
      downloaded: this.downloaded,
      eps: this.eps,
      bookId: this.bookId,
    );
  }

  factory DownloadPackage.fromJson(Map<String, dynamic> json) =>
      _$DownloadPackageFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadPackageToJson(this);
}

@JsonSerializable()
class DownloadPackageResponse extends ResultInfo {
  DownloadPackage? data;

  DownloadPackageResponse({this.data});

  factory DownloadPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$DownloadPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadPackageResponseToJson(this);
}

@JsonSerializable()
class DownloadPackageListResponse extends ResultInfo {
  List<DownloadPackage>? data;

  DownloadPackageListResponse({this.data});

  factory DownloadPackageListResponse.fromJson(Map<String, dynamic> json) =>
      _$DownloadPackageListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadPackageListResponseToJson(this);
}
