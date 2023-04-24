import 'package:love_novel/data/models/public/inapp_product.dart';
import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_packages.g.dart';

@JsonSerializable()
class AppPackages {
  @JsonKey(name: "remove_ads")
  List<InAppProduct>? removeAds;
  List<InAppProduct>? wallet;
  AppPackages({this.removeAds, this.wallet});

  factory AppPackages.fromJson(Map<String, dynamic> json) =>
      _$AppPackagesFromJson(json);

  Map<String, dynamic> toJson() => _$AppPackagesToJson(this);
}

@JsonSerializable()
class AppPackagesResponse extends ResultInfo {
  AppPackages? data;

  AppPackagesResponse({this.data});

  factory AppPackagesResponse.fromJson(Map<String, dynamic> json) =>
      _$AppPackagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppPackagesResponseToJson(this);
}

@JsonSerializable()
class AppPackagesListResponse extends ResultInfo {
  List<AppPackages>? data;

  AppPackagesListResponse({this.data});

  factory AppPackagesListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppPackagesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppPackagesListResponseToJson(this);
}
