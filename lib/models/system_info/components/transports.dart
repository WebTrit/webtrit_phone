import 'package:equatable/equatable.dart';

import 'websocket.dart';

class Transports with EquatableMixin {
  Transports({
    this.websocket,
  });

  final Websocket? websocket;

  @override
  List<Object?> get props => [websocket];

  @override
  bool get stringify => true;
}
