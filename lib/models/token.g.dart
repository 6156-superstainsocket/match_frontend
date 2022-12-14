// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      refresh: json['refresh'] as String? ?? '',
      access: json['access'] as String? ?? '',
      user: json['user'] == null
          ? null
          : Account.fromJson(json['user'] as Map<String, dynamic>),
      detail: json['detail'] as String? ?? '',
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
      'user': instance.user,
      'detail': instance.detail,
    };
