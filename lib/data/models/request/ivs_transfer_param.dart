import 'package:json_annotation/json_annotation.dart';

part 'ivs_transfer_param.g.dart';

@JsonSerializable()
class IvsTransferParam {
  @JsonKey(name: "receiver_name")
  String? receiverName;
  String? message;
  int? amount;
  IvsTransferParam({
    this.receiverName,
    this.message,
    this.amount,
  });
  factory IvsTransferParam.fromJson(Map<String, dynamic> json) =>
      _$IvsTransferParamFromJson(json);
  Map<String, dynamic> toJson() => _$IvsTransferParamToJson(this);
}
