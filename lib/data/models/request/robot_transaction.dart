import 'package:json_annotation/json_annotation.dart';

part 'robot_transaction.g.dart';

@JsonSerializable()
class RobotTransaction {
  String? productId;
  String? purchaseDate;
  String? revenueCatId;
  RobotTransaction(
      {required this.productId,
      required this.purchaseDate,
      required this.revenueCatId});
  factory RobotTransaction.fromJson(Map<String, dynamic> json) =>
      _$RobotTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$RobotTransactionToJson(this);
}
