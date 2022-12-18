// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupUserListResponse _$GroupUserListResponseFromJson(
        Map<String, dynamic> json) =>
    GroupUserListResponse(
      count: json['count'] as int? ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => GroupUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GroupUserListResponseToJson(
        GroupUserListResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
