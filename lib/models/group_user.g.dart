// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupUser _$GroupUserFromJson(Map<String, dynamic> json) => GroupUser(
      group: json['group'] as int? ?? 0,
      userApproved: json['user_approved'] as bool? ?? false,
      adminApproved: json['admin_approved'] as bool? ?? false,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      detail: json['detail'] as String? ?? '',
    );

Map<String, dynamic> _$GroupUserToJson(GroupUser instance) => <String, dynamic>{
      'group': instance.group,
      'user_approved': instance.userApproved,
      'admin_approved': instance.adminApproved,
      'user': instance.user,
      'tags': instance.tags,
      'detail': instance.detail,
    };
