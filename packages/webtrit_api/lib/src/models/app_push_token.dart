// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_push_token_type.dart';

part 'app_push_token.freezed.dart';

part 'app_push_token.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AppPushToken with _$AppPushToken {
  const AppPushToken({required this.type, required this.value});

  @override
  final AppPushTokenType type;

  @override
  final String value;

  factory AppPushToken.fromJson(Map<String, dynamic> json) =>
      _$AppPushTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AppPushTokenToJson(this);
}
