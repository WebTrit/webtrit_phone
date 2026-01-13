import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Abstract factory to create RTCPeerConnection instances.
abstract interface class PeerConnectionFactory {
  Future<RTCPeerConnection> create([
    Map<String, dynamic> configuration = const {},
    Map<String, dynamic> constraints = const {},
  ]);
}

/// Default implementation using the actual Flutter WebRTC plugin.
class DefaultPeerConnectionFactory implements PeerConnectionFactory {
  const DefaultPeerConnectionFactory();

  @override
  Future<RTCPeerConnection> create([
    Map<String, dynamic> configuration = const {},
    Map<String, dynamic> constraints = const {},
  ]) {
    final defaultConfiguration = {
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ],
    };

    // Use default configuration only if the provided one is empty.
    // This allows passing specific configurations when needed.
    final effectiveConfiguration = configuration.isEmpty ? defaultConfiguration : configuration;

    return createPeerConnection(effectiveConfiguration, constraints);
  }
}
