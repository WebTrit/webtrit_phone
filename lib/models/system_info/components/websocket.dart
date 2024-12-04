import 'package:equatable/equatable.dart';

class Websocket with EquatableMixin {
  Websocket({
    this.version,
  });

  final String? version;

  @override
  List<Object?> get props => [version];

  @override
  bool get stringify => true;
}
