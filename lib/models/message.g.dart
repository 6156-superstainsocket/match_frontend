// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int,
      type: json['type'] as int,
      userId: json['userId'] as int? ?? 0,
      userName: json['userName'] as String? ?? '',
      userIconId: json['userIconId'] as int? ?? 0,
      tagId: json['tagId'] as int? ?? 0,
      tagName: json['tagName'] as String? ?? '',
      tagIconId: json['tagIconId'] as int? ?? 0,
      groupId: json['groupId'] as int? ?? 0,
      groupName: json['groupName'] as String? ?? '',
      groupIconId: json['groupIconId'] as int? ?? 0,
      hasRead: json['hasRead'] as bool? ?? false,
      inviteByUserId: json['inviteByUserId'] as int? ?? 0,
      inviteByUserName: json['inviteByUserName'] as String? ?? '',
      inviteByUserIconId: json['inviteByUserIconId'] as int? ?? 0,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userIconId': instance.userIconId,
      'tagId': instance.tagId,
      'tagName': instance.tagName,
      'tagIconId': instance.tagIconId,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'groupIconId': instance.groupIconId,
      'type': instance.type,
      'hasRead': instance.hasRead,
      'inviteByUserId': instance.inviteByUserId,
      'inviteByUserName': instance.inviteByUserName,
      'inviteByUserIconId': instance.inviteByUserIconId,
    };
