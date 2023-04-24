// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'robot_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RobotTransaction _$RobotTransactionFromJson(Map<String, dynamic> json) =>
    RobotTransaction(
      productId: json['productId'] as String?,
      purchaseDate: json['purchaseDate'] as String?,
      revenueCatId: json['revenueCatId'] as String?,
    );

Map<String, dynamic> _$RobotTransactionToJson(RobotTransaction instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'purchaseDate': instance.purchaseDate,
      'revenueCatId': instance.revenueCatId,
    };
