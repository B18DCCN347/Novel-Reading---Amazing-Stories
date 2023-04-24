// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ivs_payment_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IvsPaymentParam _$IvsPaymentParamFromJson(Map<String, dynamic> json) =>
    IvsPaymentParam(
      productType: json['product_type'] as String?,
      paymentMethod: json['payment_method'] as String?,
      robotId: json['robot_id'] as String?,
      productId: json['product_id'] as String?,
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$IvsPaymentParamToJson(IvsPaymentParam instance) =>
    <String, dynamic>{
      'product_type': instance.productType,
      'payment_method': instance.paymentMethod,
      'robot_id': instance.robotId,
      'product_id': instance.productId,
      'amount': instance.amount,
    };
