import 'package:json_annotation/json_annotation.dart';

part 'auth_result.g.dart';

@JsonSerializable()
class AuthResult {
  String? uuid;
  String? token;
  String? authProvider;
  bool? success;
  AuthResult({
    this.uuid,
    this.token,
    this.authProvider,
    this.success,
  });
  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResultToJson(this);
}
