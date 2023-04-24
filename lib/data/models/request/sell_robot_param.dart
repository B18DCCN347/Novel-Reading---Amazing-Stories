import 'package:json_annotation/json_annotation.dart';

part 'sell_robot_param.g.dart';

@JsonSerializable()
class SellRobotParam {
  @JsonKey(name: "robot_id")
  String? robotId;
  int? amount;
  SellRobotParam({
    this.robotId,
    this.amount,
  });
  factory SellRobotParam.fromJson(Map<String, dynamic> json) =>
      _$SellRobotParamFromJson(json);
  Map<String, dynamic> toJson() => _$SellRobotParamToJson(this);
}
