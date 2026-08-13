import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_type.dart';
import 'user_session_status.dart';

part 'user_session.freezed.dart';

part 'user_session.g.dart';

/// One of the user's sessions, as returned by `GET /user/sessions`.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserSession with _$UserSession {
  const UserSession({
    required this.id,
    required this.current,
    required this.status,
    this.userAgent,
    this.ip,
    this.location,
    this.lastActivityIp,
    this.lastActivityLocation,
    this.appType,
    this.appIdentifier,
    this.appBundleId,
    this.createdAt,
    this.lastActivityAt,
  });

  /// Session identifier, used to revoke this session.
  @override
  final String id;

  /// Whether this is the session the app is currently using.
  @override
  final bool current;

  @override
  @JsonKey(unknownEnumValue: UserSessionStatus.unknown)
  final UserSessionStatus status;

  /// `User-Agent` captured at session creation; stored as received, not validated.
  @override
  final String? userAgent;

  @override
  final String? ip;

  /// ISO 3166-1 alpha-2 country code resolved once, at session creation.
  @override
  final String? location;

  @override
  final String? lastActivityIp;

  /// ISO 3166-1 alpha-2 country code of [lastActivityIp], resolved per request,
  /// so it may differ from [location] for a roaming device.
  @override
  final String? lastActivityLocation;

  @override
  final AppType? appType;

  @override
  final String? appIdentifier;

  @override
  final String? appBundleId;

  @override
  final DateTime? createdAt;

  @override
  final DateTime? lastActivityAt;

  factory UserSession.fromJson(Map<String, Object?> json) => _$UserSessionFromJson(json);

  Map<String, Object?> toJson() => _$UserSessionToJson(this);
}
