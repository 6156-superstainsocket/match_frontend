// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iconId: json['iconId'] as int? ?? 0,
      allowWithoutApproval: json['allowWithoutApproval'] as bool? ?? false,
      customTags: (json['customTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'iconId': instance.iconId,
      'allowWithoutApproval': instance.allowWithoutApproval,
      'customTags': instance.customTags,
      'id': instance.id,
    };
