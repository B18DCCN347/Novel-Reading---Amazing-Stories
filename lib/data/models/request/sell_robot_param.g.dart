// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_robot_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellRobotParam _$SellRobotParamFromJson(Map<String, dynamic> json) =>
    SellRobotParam(
      robotId: json['robot_id'] as String?,
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$SellRobotParamToJson(SellRobotParam instance) =>
    <String, dynamic>{
      'robot_id': instance.robotId,
      'amount': instance.amount,
    };
