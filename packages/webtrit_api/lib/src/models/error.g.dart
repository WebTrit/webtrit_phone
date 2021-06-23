// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    code: json['code'] as String,
    refining: (json['refining'] as List<dynamic>?)
        ?.map((e) => ErrorRefining.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

ErrorRefining _$ErrorRefiningFromJson(Map<String, dynamic> json) {
  return ErrorRefining(
    path: json['path'] as String,
    reason: json['reason'] as String,
  );
}
