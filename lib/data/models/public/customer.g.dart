// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as int?,
      appid: json['appid'] as int?,
      uuid: json['uuid'] as String?,
      createdDate: json['createdDate'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      authProvider: json['authProvider'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'appid': instance.appid,
      'uuid': instance.uuid,
      'createdDate': instance.createdDate,
      'username': instance.username,
      'email': instance.email,
      'authProvider': instance.authProvider,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      data: json['data'] == null
          ? null
          : Customer.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

CustomerListResponse _$CustomerListResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CustomerListResponseToJson(
        CustomerListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
