import 'package:love_novel/data/models/request/robot_transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'robot_purchase_info.g.dart';

@JsonSerializable()
class RobotPurchaseInfo {
  List<RobotTransaction> transactions;
  RobotPurchaseInfo(
      {required this.transactions});
  factory RobotPurchaseInfo.fromJson(Map<String, dynamic> json) =>
      _$RobotPurchaseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RobotPurchaseInfoToJson(this);
}
