import 'package:json_annotation/json_annotation.dart';

part 'secret_info.g.dart';

@JsonSerializable()
class SecretInfo {
  @JsonKey(name: "grant_type")
  final String grantType;
  @JsonKey(name: "client_id")
  final String clientId;
  @JsonKey(name: "client_secret")
  final String clientSecret;
  @JsonKey(name: "username")
  final String userName;
  @JsonKey(name: "password")
  final String password;
  SecretInfo(
      {required this.userName,
      required this.password,
      required this.grantType,
      required this.clientId,
      required this.clientSecret});
  factory SecretInfo.fromJson(Map<String, dynamic> json) =>
      _$SecretInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SecretInfoToJson(this);
}
