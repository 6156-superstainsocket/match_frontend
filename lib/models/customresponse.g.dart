// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomResponse _$CustomResponseFromJson(Map<String, dynamic> json) =>
    CustomResponse(
      data: json['data'],
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$CustomResponseToJson(CustomResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
    };
