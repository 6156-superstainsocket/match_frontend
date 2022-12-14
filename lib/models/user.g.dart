// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      iconId: json['iconid'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isGoogle: json['is_google'] as bool? ?? false,
      userId: json['user'] as int? ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'iconid': instance.iconId,
      'description': instance.description,
      'phone': instance.phone,
      'is_google': instance.isGoogle,
      'tags': instance.tags,
      'user': instance.userId,
    };
