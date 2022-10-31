import 'package:demo/models/tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  String name;

  @JsonKey(defaultValue: "")
  String? description;

  int iconId;

  @JsonKey(defaultValue: false)
  bool? allowWithoutApproval;

  List<Tag>? customTags;

  Group({
    required this.name,
    this.description,
    required this.iconId,
    this.allowWithoutApproval,
    this.customTags,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
