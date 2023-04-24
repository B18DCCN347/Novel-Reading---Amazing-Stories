import 'package:json_annotation/json_annotation.dart';

part 'secret_code_param.g.dart';

@JsonSerializable()
class SecretCodeParam {
  @JsonKey(name: "user_name")
  final String userName;
  SecretCodeParam({
    required this.userName,
  });
  factory SecretCodeParam.fromJson(Map<String, dynamic> json) =>
      _$SecretCodeParamFromJson(json);
  Map<String, dynamic> toJson() => _$SecretCodeParamToJson(this);
}
