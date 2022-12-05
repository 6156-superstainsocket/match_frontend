import 'package:json_annotation/json_annotation.dart';

part 'customresponse.g.dart';

@JsonSerializable()
class CustomResponse {
  dynamic data;

  @JsonKey(defaultValue: "")
  String? message;

  @JsonKey(defaultValue: "")
  String? status;

  CustomResponse({this.data, this.status, this.message});

  factory CustomResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomResponseToJson(this);
}
