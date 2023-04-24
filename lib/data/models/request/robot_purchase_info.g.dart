// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'robot_purchase_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RobotPurchaseInfo _$RobotPurchaseInfoFromJson(Map<String, dynamic> json) =>
    RobotPurchaseInfo(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => RobotTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RobotPurchaseInfoToJson(RobotPurchaseInfo instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
    };
