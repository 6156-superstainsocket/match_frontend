// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      fromUser: json['from_user'] == null
          ? null
          : User.fromJson(json['from_user'] as Map<String, dynamic>),
      toUser: json['to_user'] == null
          ? null
          : User.fromJson(json['to_user'] as Map<String, dynamic>),
      tag: json['tag'] == null
          ? null
          : Tag.fromJson(json['tag'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      hasAccept: json['has_accept'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'from_user': instance.fromUser,
      'to_user': instance.toUser,
      'tag': instance.tag,
      'group': instance.group,
      'has_accept': instance.hasAccept,
    };
