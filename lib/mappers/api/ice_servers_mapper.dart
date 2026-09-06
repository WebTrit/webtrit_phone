import 'package:clock/clock.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin IceServersApiMapper {
  /// Maps the API response into the domain configuration.
  ///
  /// The backend may declare the credentials' lifetime as an absolute
  /// `expires_at`, as a relative `ttl`, or - a deployment that tracks neither -
  /// as nothing at all. The domain model keeps one absolute instant, so a
  /// relative lifetime is resolved against [clock] here (injectable in tests)
  /// and a response that declares neither is treated as already expired: its
  /// servers still serve the call that fetched them, and the next poll asks
  /// again.
  IceServersConfig iceServersConfigFromApi(api.IceServersResponse response) {
    final now = clock.now();
    final ttlSeconds = response.ttl;

    return IceServersConfig(
      // Entries without a URL are dropped here rather than downstream: what the
      // model carries is what a peer connection is given.
      servers: response.iceServers.where((server) => server.urls.isNotEmpty).map(rtcIceServerFromApi).toList(),
      expiresAt: response.expiresAt ?? (ttlSeconds != null ? now.add(Duration(seconds: ttlSeconds)) : now),
    );
  }

  /// Renders one entry as the `RTCIceServer` dictionary flutter_webrtc expects.
  ///
  /// `username` and `credential` are absent for STUN entries and present for
  /// TURN ones, so they are only written when the backend sent them.
  Map<String, dynamic> rtcIceServerFromApi(api.IceServer iceServer) => {
    'urls': List<String>.unmodifiable(iceServer.urls),
    if (iceServer.username != null) 'username': iceServer.username,
    if (iceServer.credential != null) 'credential': iceServer.credential,
  };
}
