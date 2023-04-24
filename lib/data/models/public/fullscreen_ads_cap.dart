import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'fullscreen_ads_cap.g.dart';

@JsonSerializable()
class FullscreenAdsCap {
  int? minChapter;
  int? minAdGapInSec;
  int? periodicGapInSec;
  bool? videoInterstitialAlternative;

  FullscreenAdsCap({
    this.minChapter,
    this.minAdGapInSec,
    this.periodicGapInSec,
    this.videoInterstitialAlternative,
  });

  factory FullscreenAdsCap.fromJson(Map<String, dynamic> json) =>
      _$FullscreenAdsCapFromJson(json);

  Map<String, dynamic> toJson() => _$FullscreenAdsCapToJson(this);
}

@JsonSerializable()
class FullscreenAdsCapResponse extends ResultInfo {
  FullscreenAdsCap? data;

  FullscreenAdsCapResponse({this.data});

  factory FullscreenAdsCapResponse.fromJson(Map<String, dynamic> json) =>
      _$FullscreenAdsCapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FullscreenAdsCapResponseToJson(this);
}

@JsonSerializable()
class FullscreenAdsCapListResponse extends ResultInfo {
  List<FullscreenAdsCap>? data;

  FullscreenAdsCapListResponse({this.data});

  factory FullscreenAdsCapListResponse.fromJson(Map<String, dynamic> json) =>
      _$FullscreenAdsCapListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FullscreenAdsCapListResponseToJson(this);
}
