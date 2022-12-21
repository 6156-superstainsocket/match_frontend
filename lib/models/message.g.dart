// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      type: json['type'] as int? ?? 0,
      hasRead: json['has_read'] as bool? ?? false,
      uid: json['uid'] as int? ?? 0,
      email: json['email'] as String? ?? '',
      content: json['content'] == null
          ? null
          : MessageContent.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'email': instance.email,
      'type': instance.type,
      'has_read': instance.hasRead,
      'content': instance.content,
    };
