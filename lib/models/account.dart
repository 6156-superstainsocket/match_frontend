import 'package:demo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  int id;

  @JsonKey(defaultValue: "")
  String? username;

  @JsonKey(defaultValue: "")
  String? password;

  @JsonKey(defaultValue: "")
  String? email;

  @JsonKey(defaultValue: "", name: 'first_name')
  String? firstname;

  @JsonKey(defaultValue: "", name: 'last_name')
  String? lastname;

  User? profile;

  @JsonKey(defaultValue: "")
  String? detail;

  Account({
    required this.id,
    this.username = '',
    this.email = '',
    this.password = '',
    this.firstname = '',
    this.lastname = '',
    this.profile,
    this.detail = '',
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
