import 'package:demo/models/message_content.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String id;

  @JsonKey(defaultValue: 0)
  int? uid;

  @JsonKey(defaultValue: "")
  String? email;

  @JsonKey(defaultValue: 0)
  int type;

  MessageContent? content;

  Message({
    required this.id,
    required this.type,
    this.uid,
    this.email,
    this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
