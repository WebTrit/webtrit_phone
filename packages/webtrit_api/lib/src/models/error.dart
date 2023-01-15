// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

part 'error.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ErrorResponse({
    required String code,
    List<ErrorRefining>? refining,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}

@freezed
class ErrorRefining with _$ErrorRefining {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ErrorRefining({
    required String path,
    required String reason,
  }) = _ErrorRefining;

  factory ErrorRefining.fromJson(Map<String, dynamic> json) => _$ErrorRefiningFromJson(json);
}
