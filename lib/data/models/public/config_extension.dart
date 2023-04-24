
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'config_extension.g.dart';

@JsonSerializable()
class ConfigExtension {
  String? liveChatSupportUrl;

  ConfigExtension({this.liveChatSupportUrl});

  factory ConfigExtension.fromJson(Map<String, dynamic> json) =>
      _$ConfigExtensionFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigExtensionToJson(this);
}

@JsonSerializable()
class ConfigExtensionResponse extends ResultInfo {
  ConfigExtension? data;

  ConfigExtensionResponse({this.data});

  factory ConfigExtensionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfigExtensionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigExtensionResponseToJson(this);
}

@JsonSerializable()
class ConfigExtensionListResponse extends ResultInfo {
  List<ConfigExtension>? data;

  ConfigExtensionListResponse({this.data});

  factory ConfigExtensionListResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfigExtensionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigExtensionListResponseToJson(this);
}
