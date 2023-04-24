import 'package:love_novel/data/models/public/fullscreen_ads_cap.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_settings.g.dart';

@JsonSerializable()
class ApiSettings {
  List<String>? bannerAdsOrder;
  FullscreenAdsCap? fullscreenAdsCap;
  bool? noAds;
  int? noAdsFirstNDays;

  ApiSettings({
    this.bannerAdsOrder,
    this.fullscreenAdsCap,
    this.noAds,
    this.noAdsFirstNDays,
  });

  factory ApiSettings.fromJson(Map<String, dynamic> json) =>
      _$ApiSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ApiSettingsToJson(this);
}

@JsonSerializable()
class ApiSettingsResponse extends ResultInfo {
  ApiSettings? data;

  ApiSettingsResponse({this.data});

  factory ApiSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiSettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiSettingsResponseToJson(this);
}

@JsonSerializable()
class ApiSettingsListResponse extends ResultInfo {
  List<ApiSettings>? data;

  ApiSettingsListResponse({this.data});

  factory ApiSettingsListResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiSettingsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiSettingsListResponseToJson(this);
}
