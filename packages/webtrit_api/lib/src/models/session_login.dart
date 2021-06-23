import 'package:json_annotation/json_annotation.dart';

import 'app_type.dart';

part 'session_login.g.dart';

@JsonSerializable(createFactory: false)
class SessionLoginRequest {
  const SessionLoginRequest({
    required this.type,
    required this.identifier,
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SessionLoginRequestToJson(this);

  final AppType type;
  final String identifier;
  final String login;
  final String password;
}

@JsonSerializable(createToJson: false)
class SessionLoginResponse {
  const SessionLoginResponse({
    required this.token,
  });

  factory SessionLoginResponse.fromJson(Map<String, dynamic> json) => _$SessionLoginResponseFromJson(json);

  final String token;
}
