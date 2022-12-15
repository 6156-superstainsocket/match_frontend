import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  @JsonKey(defaultValue: 0)
  int? id;

  @JsonKey(defaultValue: "")
  String? name;

  @JsonKey(defaultValue: "")
  String? description;

  @JsonKey(defaultValue: 0, name: "icon_id")
  int? iconId;

  @JsonKey(defaultValue: false)
  bool? isMatch;

  Tag({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.iconId = 0,
    this.isMatch = false,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}
