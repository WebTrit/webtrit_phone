import 'package:json_annotation/json_annotation.dart';

import 'push_token_type.dart';

part 'app_push_tokens.g.dart';

@JsonSerializable(
  createFactory: false,
  fieldRename: FieldRename.snake,
)
class AppCreatePushTokenRequest {
  const AppCreatePushTokenRequest({
    required this.type,
    required this.value,
  });

  Map<String, dynamic> toJson() => _$AppCreatePushTokenRequestToJson(this);

  final PushTokenType type;
  final String value;
}
