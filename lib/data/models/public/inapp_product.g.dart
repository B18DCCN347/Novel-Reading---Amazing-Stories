// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inapp_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InAppProduct _$InAppProductFromJson(Map<String, dynamic> json) => InAppProduct(
      package: json['package'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      coins: json['coins'] as int?,
    );

Map<String, dynamic> _$InAppProductToJson(InAppProduct instance) =>
    <String, dynamic>{
      'package': instance.package,
      'title': instance.title,
      'desc': instance.desc,
      'unit': instance.unit,
      'price': instance.price,
      'coins': instance.coins,
    };

InAppProductResponse _$InAppProductResponseFromJson(
        Map<String, dynamic> json) =>
    InAppProductResponse(
      data: json['data'] == null
          ? null
          : InAppProduct.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$InAppProductResponseToJson(
        InAppProductResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

InAppProductListResponse _$InAppProductListResponseFromJson(
        Map<String, dynamic> json) =>
    InAppProductListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => InAppProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$InAppProductListResponseToJson(
        InAppProductListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
