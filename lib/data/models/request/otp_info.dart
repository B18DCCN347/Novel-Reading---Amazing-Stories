import 'package:json_annotation/json_annotation.dart';

part 'otp_info.g.dart';

@JsonSerializable()
class OtpInfo {
  final String otp;
  OtpInfo({required this.otp});
  factory OtpInfo.fromJson(Map<String, dynamic> json) =>
      _$OtpInfoFromJson(json);
  Map<String, dynamic> toJson() => _$OtpInfoToJson(this);
}
