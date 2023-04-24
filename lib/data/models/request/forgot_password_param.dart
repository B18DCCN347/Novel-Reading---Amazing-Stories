import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_param.g.dart';

@JsonSerializable()
class ForgotPasswordParam {
  @JsonKey(name: "user_name")
  final String? userName;
  @JsonKey(name: "secret_code")
  final String secretCode;
  ForgotPasswordParam({
    required this.userName,
    required this.secretCode,
  });
  factory ForgotPasswordParam.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordParamFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordParamToJson(this);
}
