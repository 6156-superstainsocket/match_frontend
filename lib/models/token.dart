import 'package:demo/models/account.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(defaultValue: "")
  String? refresh;

  @JsonKey(defaultValue: "")
  String? access;

  Account? user;

  @JsonKey(defaultValue: "")
  String? detail;

  Token({
    this.refresh = '',
    this.access = '',
    this.user,
    this.detail = '',
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
