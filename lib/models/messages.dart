import 'package:demo/models/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

@JsonSerializable()
class Messages {
  int count;
  @JsonKey(defaultValue: [])
  List<Message>? content;

  Messages({
    required this.count,
    this.content = const [],
  });

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}
