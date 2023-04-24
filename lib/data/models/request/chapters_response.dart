import 'package:json_annotation/json_annotation.dart';
import 'package:love_novel/data/models/public/episode.dart';

part 'chapters_response.g.dart';

@JsonSerializable()
class ChaptersResponse {
  List<Episode>? data;
  bool? hasNext;
  bool? success;
  ChaptersResponse({
    this.data,
    this.hasNext,
    this.success,
  });
  factory ChaptersResponse.fromJson(Map<String, dynamic> json) =>
      _$ChaptersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChaptersResponseToJson(this);
}
