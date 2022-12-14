// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      firstname: json['first_name'] as String? ?? '',
      lastname: json['last_name'] as String? ?? '',
      profile: json['profile'] == null
          ? null
          : User.fromJson(json['profile'] as Map<String, dynamic>),
      detail: json['detail'] as String? ?? '',
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'profile': instance.profile,
      'detail': instance.detail,
    };
