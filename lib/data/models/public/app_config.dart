import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/api_settings.dart';
import 'package:love_novel/data/models/public/config_extension.dart';
import 'package:love_novel/data/models/public/inapp_product.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_config.g.dart';

@JsonSerializable()
class AppConfig {
  List<Category>? contentCategory;
  List<InAppProduct>? iap;
  Map<String, List<InAppProduct>>? iapPackages;
  ApiSettings? apiSettings;
  bool? success;
  ConfigExtension? ext;

  AppConfig({
    this.contentCategory,
    this.iap,
    this.iapPackages,
    this.apiSettings,
    this.ext,
    this.success,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}

@JsonSerializable()
class AppConfigResponse extends ResultInfo {
  AppConfig? data;

  AppConfigResponse({this.data});

  factory AppConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$AppConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigResponseToJson(this);
}

@JsonSerializable()
class AppConfigListResponse extends ResultInfo {
  List<AppConfig>? data;

  AppConfigListResponse({this.data});

  factory AppConfigListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppConfigListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigListResponseToJson(this);
}
