import 'package:json_annotation/json_annotation.dart';

part 'purchase_result.g.dart';


@JsonSerializable()
class PurchaseResult {
  int? transErrorCode;
  String? transStatus;
  bool? success;
  PurchaseResult({
    this.transErrorCode,
    this.transStatus,
    this.success,
  });
  factory PurchaseResult.fromJson(Map<String, dynamic> json) =>
      _$PurchaseResultFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseResultToJson(this);
}
