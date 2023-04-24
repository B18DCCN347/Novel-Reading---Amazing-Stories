import 'package:json_annotation/json_annotation.dart';
import 'package:love_novel/data/models/public/customer.dart';

part 'validate_token_result.g.dart';

@JsonSerializable()
class ValidateTokenResult {
  bool? success;
  Customer? customer;
  ValidateTokenResult({
    this.success,
  });
  factory ValidateTokenResult.fromJson(Map<String, dynamic> json) =>
      _$ValidateTokenResultFromJson(json);
  Map<String, dynamic> toJson() => _$ValidateTokenResultToJson(this);
}
