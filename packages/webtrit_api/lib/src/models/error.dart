// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

part 'error.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ErrorResponse({
    required String code,
    List<ErrorDetail>? details,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}

@freezed
class ErrorDetail with _$ErrorDetail {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ErrorDetail({
    required String path,
    required String reason,
  }) = _ErrorDetail;

  factory ErrorDetail.fromJson(Map<String, dynamic> json) => _$ErrorDetailFromJson(json);
}
