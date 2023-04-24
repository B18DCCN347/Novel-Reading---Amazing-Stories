import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'stat.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.stat)
class Stat extends HiveObject {
  @HiveField(0)
  int? contentId;
  @HiveField(1)
  int? like;
  @HiveField(2)
  double? rate;
  @HiveField(3)
  int? rateBy;
  @HiveField(4)
  int? read;

  Stat({
    this.contentId,
    this.like,
    this.rate,
    this.rateBy,
    this.read,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Map<String, dynamic> toJson() => _$StatToJson(this);
}

@JsonSerializable()
class StatResponse extends ResultInfo {
  Stat? data;

  StatResponse({this.data});

  factory StatResponse.fromJson(Map<String, dynamic> json) =>
      _$StatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatResponseToJson(this);
}

@JsonSerializable()
class StatListResponse extends ResultInfo {
  List<Stat>? data;

  StatListResponse({this.data});

  factory StatListResponse.fromJson(Map<String, dynamic> json) =>
      _$StatListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatListResponseToJson(this);
}
