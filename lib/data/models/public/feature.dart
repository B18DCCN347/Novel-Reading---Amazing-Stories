import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'feature.g.dart';

@JsonSerializable()
class Feature {
  String? feature;
  int? times;
  int? validFrom;
  int? validThru;
  Feature({
    this.feature,
    this.times,
    this.validFrom,
    this.validThru,
  });

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}

@JsonSerializable()
class FeatureResponse extends ResultInfo {
  Feature? data;

  FeatureResponse({this.data});

  factory FeatureResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureResponseToJson(this);
}

@JsonSerializable()
class FeatureListResponse extends ResultInfo {
  List<Feature>? data;

  FeatureListResponse({this.data});

  factory FeatureListResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureListResponseToJson(this);
}
