import 'package:webtrit_signaling/webtrit_signaling.dart';

sealed class SignalingModuleEvent {}

class SignalingConnecting extends SignalingModuleEvent {}

class SignalingConnected extends SignalingModuleEvent {}

/// Connect attempt failed (SocketException, TlsException, etc.).
///
/// [isRepeated] is true when the error matches the previous connect attempt.
/// [recommendedReconnectDelay] is a hint; consumers decide whether to use it.
class SignalingConnectionFailed extends SignalingModuleEvent {
  SignalingConnectionFailed({required this.error, required this.isRepeated, required this.recommendedReconnectDelay});

  final Object error;
  final bool isRepeated;
  final Duration recommendedReconnectDelay;
}

class SignalingDisconnecting extends SignalingModuleEvent {}

/// Connection closed by the server or client.
///
/// [recommendedReconnectDelay]:
///   - [Duration.zero]        -- reconnect immediately (e.g. code 4441)
///   - positive [Duration]    -- slow reconnect
///   - null                   -- do not reconnect (e.g. protocolError)
class SignalingDisconnected extends SignalingModuleEvent {
  SignalingDisconnected({
    required this.code,
    required this.reason,
    required this.knownCode,
    required this.recommendedReconnectDelay,
  });

  final int? code;
  final String? reason;
  final SignalingDisconnectCode knownCode;
  final Duration? recommendedReconnectDelay;
}

class SignalingHandshakeReceived extends SignalingModuleEvent {
  SignalingHandshakeReceived({required this.handshake});

  final StateHandshake handshake;
}

class SignalingProtocolEvent extends SignalingModuleEvent {
  SignalingProtocolEvent({required this.event});

  final Event event;
}
