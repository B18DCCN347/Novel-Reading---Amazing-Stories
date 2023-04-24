import 'package:love_novel/data/models/request/result_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
class Customer {
  int? id;
  int? appid;
  String? uuid;
  String? createdDate;
  String? username;
  String? email;
  String? authProvider;
  Customer({
    this.id,
    this.appid,
    this.uuid,
    this.createdDate,
    this.username,
    this.email,
    this.authProvider,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class CustomerResponse extends ResultInfo {
  Customer? data;

  CustomerResponse({this.data});

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class CustomerListResponse extends ResultInfo {
  List<Customer>? data;

  CustomerListResponse({this.data});

  factory CustomerListResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerListResponseToJson(this);
}
