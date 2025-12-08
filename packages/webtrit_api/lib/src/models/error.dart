// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

part 'error.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ErrorResponse with _$ErrorResponse {
  const ErrorResponse({this.code, this.message, this.details});

  @override
  final String? code;

  @override
  final String? message;

  @override
  final ErrorDetail? details;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ErrorDetail with _$ErrorDetail {
  const ErrorDetail({this.path, required this.reason});

  @override
  final String? path;

  @override
  final String reason;

  factory ErrorDetail.fromJson(Map<String, dynamic> json) => _$ErrorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDetailToJson(this);
}
