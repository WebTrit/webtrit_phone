import 'package:freezed_annotation/freezed_annotation.dart';

part 'ice_servers.freezed.dart';

part 'ice_servers.g.dart';

/// The deployment's own STUN/TURN configuration, as served by
/// `GET /api/v1/user/ice-servers`.
///
/// TURN credentials are time-limited: [ttl] is the lifetime the backend grants
/// them and [expiresAt] the absolute moment they stop working, so a client that
/// keeps a session open longer than the window must fetch the configuration
/// again.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class IceServersResponse with _$IceServersResponse {
  const IceServersResponse({this.iceServers = const [], this.ttl, this.expiresAt});

  @override
  final List<IceServer> iceServers;

  /// Lifetime of the returned credentials in seconds. `null` = not declared.
  @override
  final int? ttl;

  /// Absolute expiration of the returned credentials. `null` = not declared.
  @override
  final DateTime? expiresAt;

  factory IceServersResponse.fromJson(Map<String, Object?> json) => _$IceServersResponseFromJson(json);

  Map<String, Object?> toJson() => _$IceServersResponseToJson(this);
}

/// A single ICE server entry, shaped after the WebRTC `RTCIceServer` dictionary.
///
/// [username] and [credential] are absent for plain STUN entries and present for
/// TURN ones.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class IceServer with _$IceServer {
  const IceServer({this.urls = const [], this.username, this.credential});

  @override
  final List<String> urls;

  @override
  final String? username;

  @override
  final String? credential;

  factory IceServer.fromJson(Map<String, Object?> json) => _$IceServerFromJson(json);

  Map<String, Object?> toJson() => _$IceServerToJson(this);
}
