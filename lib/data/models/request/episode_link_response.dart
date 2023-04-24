import 'package:json_annotation/json_annotation.dart';

part 'episode_link_response.g.dart';

@JsonSerializable()
class EpisodeLinkResponse {
  String? link;
  String? status;
  bool? success;
  EpisodeLinkResponse({
    this.link,
    this.status,
    this.success,
  });
  factory EpisodeLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$EpisodeLinkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeLinkResponseToJson(this);
}
