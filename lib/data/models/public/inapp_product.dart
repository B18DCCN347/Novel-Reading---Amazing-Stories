import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'inapp_product.g.dart';

@JsonSerializable()
class InAppProduct {
  String? package;
  String? title;
  String? desc;
  String? unit;
  double? price;
  int? coins;

  InAppProduct(
      {this.package, this.title, this.desc, this.unit, this.price, this.coins});

  factory InAppProduct.fromJson(Map<String, dynamic> json) =>
      _$InAppProductFromJson(json);

  Map<String, dynamic> toJson() => _$InAppProductToJson(this);
}

@JsonSerializable()
class InAppProductResponse extends ResultInfo {
  InAppProduct? data;

  InAppProductResponse({this.data});

  factory InAppProductResponse.fromJson(Map<String, dynamic> json) =>
      _$InAppProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InAppProductResponseToJson(this);
}

@JsonSerializable()
class InAppProductListResponse extends ResultInfo {
  List<InAppProduct>? data;

  InAppProductListResponse({this.data});

  factory InAppProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$InAppProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InAppProductListResponseToJson(this);
}
