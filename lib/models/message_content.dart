import 'package:demo/models/group.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_content.g.dart';

@JsonSerializable()
class MessageContent {
  @JsonKey(name: "from_user")
  User? fromUser;

  @JsonKey(name: "to_user")
  User? toUser;

  Tag? tag;

  Group? group;

  @JsonKey(defaultValue: false, name: "has_accept")
  bool hasAccept;

  MessageContent({
    this.fromUser,
    this.toUser,
    this.tag,
    this.group,
    this.hasAccept = false,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) =>
      _$MessageContentFromJson(json);
  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}
