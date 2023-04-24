import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:love_novel/app/global/hive_boxes.dart';

part 'action_status.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.actionStatus)
class ActionStatus extends HiveObject {
  @HiveField(0)
  bool? success;
  @HiveField(1)
  bool? hasLiked;
  @HiveField(2)
  bool? hasRate;
  @HiveField(3)
  int? rate;
  @HiveField(4)
  bool? hasRead;
  @HiveField(5)
  int? episodeIndex;
  @HiveField(6)
  String? bookId;
  ActionStatus({
    this.success,
    this.hasLiked,
    this.hasRate,
    this.rate,
    this.hasRead,
    this.episodeIndex,
    this.bookId,
  });
  factory ActionStatus.fromJson(Map<String, dynamic> json) =>
      _$ActionStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ActionStatusToJson(this);
}
