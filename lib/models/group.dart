import 'package:demo/models/tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  @JsonKey(defaultValue: "")
  String? name;

  @JsonKey(defaultValue: "")
  String? description;

  @JsonKey(defaultValue: 0)
  int? iconId;

  @JsonKey(defaultValue: false)
  bool? allowWithoutApproval;

  List<Tag>? customTags;

  int id;

  Group({
    required this.id,
    this.name = '',
    this.description = '',
    this.iconId = 0,
    this.allowWithoutApproval = false,
    this.customTags = const [],
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
