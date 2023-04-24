import 'package:json_annotation/json_annotation.dart';

part 'ivs_payment_param.g.dart';

@JsonSerializable()
class IvsPaymentParam {
  @JsonKey(name: "product_type")
  String? productType;
  @JsonKey(name: "payment_method")
  String? paymentMethod;
  @JsonKey(name: "robot_id")
  String? robotId;
  @JsonKey(name: "product_id")
  String? productId;
  int? amount;
  IvsPaymentParam({
    this.productType,
    this.paymentMethod,
    this.robotId,
    this.productId,
    this.amount,
  });
  factory IvsPaymentParam.fromJson(Map<String, dynamic> json) =>
      _$IvsPaymentParamFromJson(json);
  Map<String, dynamic> toJson() => _$IvsPaymentParamToJson(this);
}
