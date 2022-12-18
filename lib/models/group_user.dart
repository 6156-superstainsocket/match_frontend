import 'package:demo/models/tag.dart';
import 'package:demo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_user.g.dart';

@JsonSerializable()
class GroupUser {
  @JsonKey(defaultValue: 0)
  int? group;

  @JsonKey(defaultValue: false, name: 'user_approved')
  bool? userApproved;

  @JsonKey(defaultValue: false, name: 'admin_approved')
  bool? adminApproved;

  User? user;

  @JsonKey(defaultValue: [])
  List<Tag>? tags;

  @JsonKey(defaultValue: "")
  String? detail;

  GroupUser({
    this.group,
    this.userApproved = false,
    this.adminApproved = false,
    this.user,
    this.tags = const [],
    this.detail = '',
  });

  factory GroupUser.fromJson(Map<String, dynamic> json) =>
      _$GroupUserFromJson(json);
  Map<String, dynamic> toJson() => _$GroupUserToJson(this);
}
