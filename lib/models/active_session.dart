import 'package:equatable/equatable.dart';

import 'package:webtrit_api/webtrit_api.dart' show AppType;

/// One of the account's active sessions, as shown on the sessions screen.
class ActiveSession extends Equatable {
  const ActiveSession({
    required this.id,
    required this.current,
    this.userAgent,
    this.location,
    this.lastActivityLocation,
    this.appType,
    this.appIdentifier,
    this.appBundleId,
    this.createdAt,
    this.lastActivityAt,
  });

  /// Identifier used to revoke this session.
  final String id;

  /// Whether this is the session this device is signed in with.
  final bool current;

  final String? userAgent;

  /// ISO 3166-1 alpha-2 country code the session was created from.
  final String? location;

  /// ISO 3166-1 alpha-2 country code of the last recorded activity.
  final String? lastActivityLocation;

  final AppType? appType;

  final String? appIdentifier;

  final String? appBundleId;

  final DateTime? createdAt;

  final DateTime? lastActivityAt;

  @override
  List<Object?> get props => [
    id,
    current,
    userAgent,
    location,
    lastActivityLocation,
    appType,
    appIdentifier,
    appBundleId,
    createdAt,
    lastActivityAt,
  ];

  @override
  bool get stringify => true;
}
