import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chapter_data.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.chapterData)
class ChapterData extends HiveObject {
  @HiveField(1)
  String bookId;
  @HiveField(2)
  String chapterId;
  @HiveField(3)
  String data;
  @HiveField(4)
  DateTime time;

  ChapterData({
    required this.bookId,
    required this.chapterId,
    required this.data,
    required this.time,
  });

  factory ChapterData.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDataToJson(this);
}

@JsonSerializable()
class ChapterDataResponse extends ResultInfo {
  ChapterData? data;

  ChapterDataResponse({this.data});

  factory ChapterDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDataResponseToJson(this);
}

@JsonSerializable()
class ChapterDataListResponse extends ResultInfo {
  List<ChapterData>? data;

  ChapterDataListResponse({this.data});

  factory ChapterDataListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDataListResponseToJson(this);
}
