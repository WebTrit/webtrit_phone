// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_push_token_type.dart';

part 'app_push_token.freezed.dart';

part 'app_push_token.g.dart';

@freezed
class AppPushToken with _$AppPushToken {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppPushToken({
    required AppPushTokenType type,
    required String value,
  }) = _AppPushToken;

  factory AppPushToken.fromJson(Map<String, dynamic> json) => _$AppPushTokenFromJson(json);
}
