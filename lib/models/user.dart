import 'package:demo/models/tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;

  @JsonKey(defaultValue: "", name: 'name')
  String? name;

  @JsonKey(defaultValue: "")
  String? email;

  @JsonKey(defaultValue: 0, name: 'iconid')
  int? iconId;

  @JsonKey(defaultValue: "")
  String? description;

  @JsonKey(defaultValue: "")
  String? phone;

  @JsonKey(defaultValue: false)
  bool? isGoogle;

  List<Tag>? tags;

  User({
    required this.id,
    this.name = '',
    this.email = '',
    this.iconId = 0,
    this.description = '',
    this.phone = '',
    this.tags = const [],
    this.isGoogle = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
