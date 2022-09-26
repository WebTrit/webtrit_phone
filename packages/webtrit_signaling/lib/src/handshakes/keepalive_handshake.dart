import 'handshake.dart';

class KeepaliveHandshake extends Handshake {
  const KeepaliveHandshake() : super();

  @override
  List<Object?> get props => [];

  static const type = 'keepalive';

  factory KeepaliveHandshake.fromJson(Map<String, dynamic> json) {
    final handshakeValue = json['handshake'];
    if (handshakeValue != type) {
      throw ArgumentError.value(handshakeValue, "handshake", "Not equal $type");
    }

    return KeepaliveHandshake();
  }

  Map<String, dynamic> toJson() {
    return {
      'handshake': type,
    };
  }
}
