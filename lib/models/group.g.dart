// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iconId: json['icon_id'] as int? ?? 0,
      allowWithoutApproval: json['allow_without_approval'] as bool? ?? false,
      customTags: (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      adminUserId: json['admin_user_id'] as int? ?? -1,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'icon_id': instance.iconId,
      'allow_without_approval': instance.allowWithoutApproval,
      'tags': instance.customTags,
      'id': instance.id,
      'admin_user_id': instance.adminUserId,
    };
