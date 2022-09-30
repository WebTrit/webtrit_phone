import 'handshake.dart';

class KeepaliveHandshake extends Handshake {
  const KeepaliveHandshake() : super();

  @override
  List<Object?> get props => [];

  static const typeValue = 'keepalive';

  factory KeepaliveHandshake.fromJson(Map<String, dynamic> json) {
    final handshakeTypeValue = json[Handshake.typeKey];
    if (handshakeTypeValue != typeValue) {
      throw ArgumentError.value(handshakeTypeValue, Handshake.typeKey, 'Not equal $typeValue');
    }

    return KeepaliveHandshake();
  }

  Map<String, dynamic> toJson() {
    return {
      Handshake.typeKey: typeValue,
    };
  }
}
