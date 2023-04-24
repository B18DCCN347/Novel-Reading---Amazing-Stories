import 'package:json_annotation/json_annotation.dart';

part 'change_password_param.g.dart';

@JsonSerializable()
class ChangePasswordParam {
  @JsonKey(name: "user_name")
  final String? userName;
  @JsonKey(name: "secret_code")
  final String? secretCode;
  @JsonKey(name: "new_password")
  final String? newPassword;
  ChangePasswordParam({
    this.userName,
    this.secretCode,
    this.newPassword,
  });
  factory ChangePasswordParam.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordParamFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordParamToJson(this);
}
