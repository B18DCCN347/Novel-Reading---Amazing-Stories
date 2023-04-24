import 'package:json_annotation/json_annotation.dart';

part "result_info.g.dart";

@JsonSerializable()
class ResultInfo {
  bool? success;
  String? message;

  ResultInfo({
    this.success,
    this.message,
  });

  factory ResultInfo.fromJson(Map<String, dynamic> json) =>
      _$ResultInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResultInfoToJson(this);
}

@JsonSerializable()
class RestStringData {
  bool? success;
  String? data;
  List<RestErrorDetail>? errors;

  RestStringData({this.success, this.data, this.errors});

  factory RestStringData.fromJson(Map<String, dynamic> json) =>
      _$RestStringDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestStringDataToJson(this);
}

@JsonSerializable()
class RestNumberData {
  bool? success;
  double? data;
  List<RestErrorDetail>? errors;

  RestNumberData({this.success, this.data, this.errors});

  factory RestNumberData.fromJson(Map<String, dynamic> json) =>
      _$RestNumberDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestNumberDataToJson(this);
}

@JsonSerializable()
class RestErrorDetail {
  int? code;
  String? type;
  String? message;

  RestErrorDetail({this.code, this.message, this.type});

  factory RestErrorDetail.fromJson(Map<String, dynamic> json) =>
      _$RestErrorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RestErrorDetailToJson(this);
}
