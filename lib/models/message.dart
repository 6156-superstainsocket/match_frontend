import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int id;

  @JsonKey(defaultValue: 0)
  int? userId;
  @JsonKey(defaultValue: "")
  String? userName;
  @JsonKey(defaultValue: 0)
  int? userIconId;

  @JsonKey(defaultValue: 0)
  int? tagId;
  @JsonKey(defaultValue: "")
  String? tagName;
  @JsonKey(defaultValue: 0)
  int? tagIconId;

  @JsonKey(defaultValue: 0)
  int? groupId;
  @JsonKey(defaultValue: "")
  String? groupName;
  @JsonKey(defaultValue: 0)
  int? groupIconId;

  int type;

  @JsonKey(defaultValue: false)
  bool? hasRead;

  @JsonKey(defaultValue: 0)
  int? inviteByUserId;
  @JsonKey(defaultValue: "")
  String? inviteByUserName;
  @JsonKey(defaultValue: 0)
  int? inviteByUserIconId;

  Message({
    required this.id,
    required this.type,
    this.userId = 0,
    this.userName = "",
    this.userIconId = 0,
    this.tagId = 0,
    this.tagName = "",
    this.tagIconId = 0,
    this.groupId = 0,
    this.groupName = "",
    this.groupIconId = 0,
    this.hasRead = false,
    this.inviteByUserId = 0,
    this.inviteByUserName = "",
    this.inviteByUserIconId = 0,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
