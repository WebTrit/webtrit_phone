import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/models/models.dart';

/// Supplies the ICE servers for a peer connection about to be created.
///
/// Resolved per connection rather than captured once, so a connection created
/// after the deployment's TURN credentials were renewed uses the new ones.
typedef IceServersResolver = Future<List<Map<String, dynamic>>> Function();

/// Abstract factory to create [RTCPeerConnection] instances.
abstract interface class PeerConnectionFactory {
  Future<RTCPeerConnection> create([
    Map<String, dynamic> configuration = const {},
    Map<String, dynamic> constraints = const {},
  ]);
}

/// Default implementation using the actual Flutter WebRTC plugin.
class DefaultPeerConnectionFactory implements PeerConnectionFactory {
  static const Map<String, dynamic> _defaultIceConfiguration = {'iceServers': kFallbackRtcIceServers};

  final Map<String, dynamic> _defaultConfiguration;
  final IceServersResolver? _iceServersResolver;

  const DefaultPeerConnectionFactory({
    Map<String, dynamic> defaultConfiguration = _defaultIceConfiguration,
    IceServersResolver? iceServersResolver,
  }) : _defaultConfiguration = defaultConfiguration,
       _iceServersResolver = iceServersResolver;

  @override
  Future<RTCPeerConnection> create([
    Map<String, dynamic> configuration = const {},
    Map<String, dynamic> constraints = const {},
  ]) async {
    // Use default configuration only if the provided one is empty.
    // This allows passing specific configurations when needed.
    final effectiveConfiguration = configuration.isEmpty ? await _resolveDefaultConfiguration() : configuration;

    return createPeerConnection(effectiveConfiguration, constraints);
  }

  Future<Map<String, dynamic>> _resolveDefaultConfiguration() async {
    final resolver = _iceServersResolver;
    if (resolver == null) return _defaultConfiguration;

    final iceServers = await resolver();
    if (iceServers.isEmpty) return _defaultConfiguration;

    return {..._defaultConfiguration, 'iceServers': iceServers};
  }
}
