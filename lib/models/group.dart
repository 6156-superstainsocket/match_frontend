import 'package:demo/models/tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  @JsonKey(defaultValue: "")
  String? name;

  @JsonKey(defaultValue: "")
  String? description;

  @JsonKey(defaultValue: 0, name: "icon_id")
  int? iconId;

  @JsonKey(defaultValue: false, name: "allow_without_approval")
  bool? allowWithoutApproval;

  @JsonKey(name: "tags")
  List<Tag>? customTags;

  int id;

  @JsonKey(name: "admin_user_id")
  int? adminUserId;

  @JsonKey(defaultValue: "")
  String? detail;

  Group({
    required this.id,
    this.name = '',
    this.description = '',
    this.iconId = 0,
    this.allowWithoutApproval = false,
    this.customTags = const [],
    this.adminUserId = -1,
    this.detail = '',
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
