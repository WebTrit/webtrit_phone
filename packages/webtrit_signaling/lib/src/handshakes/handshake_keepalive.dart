import 'handshake.dart';

class HandshakeKeepalive extends Handshake {
  const HandshakeKeepalive() : super();

  @override
  List<Object?> get props => [];

  static const type = 'keepalive';

  factory HandshakeKeepalive.fromJson(Map<String, dynamic> json) {
    final handshakeValue = json['handshake'];
    if (handshakeValue != type) {
      throw ArgumentError.value(handshakeValue, "handshake", "Not equal $type");
    }

    return HandshakeKeepalive();
  }

  Map<String, dynamic> toJson() {
    return {
      'handshake': type,
    };
  }
}
