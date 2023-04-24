// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ivs_transfer_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IvsTransferParam _$IvsTransferParamFromJson(Map<String, dynamic> json) =>
    IvsTransferParam(
      receiverName: json['receiver_name'] as String?,
      message: json['message'] as String?,
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$IvsTransferParamToJson(IvsTransferParam instance) =>
    <String, dynamic>{
      'receiver_name': instance.receiverName,
      'message': instance.message,
      'amount': instance.amount,
    };
