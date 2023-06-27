// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session_response.dart';

part 'session_undefine_response.freezed.dart';

part 'session_undefine_response.g.dart';

@freezed
class SessionUndefineResponse with _$SessionUndefineResponse implements BaseSessionResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionUndefineResponse({
    required Map<String, dynamic> data,
  }) = _SessionUndefineResponse;

  factory SessionUndefineResponse.fromJson(Map<String, dynamic> json) => _$SessionUndefineResponseFromJson(json);
}
