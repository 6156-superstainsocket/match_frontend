// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupListResponse _$GroupListResponseFromJson(Map<String, dynamic> json) =>
    GroupListResponse(
      count: json['count'] as int? ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GroupListResponseToJson(GroupListResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
