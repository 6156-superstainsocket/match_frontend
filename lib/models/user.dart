import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String firstName;
  String lastName;
  String email;
  int iconId;

  @JsonKey(defaultValue: "")
  String? description;

  @JsonKey(defaultValue: "")
  String? phone;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.iconId,
    this.description,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
