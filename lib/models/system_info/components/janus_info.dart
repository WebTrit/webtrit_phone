import 'package:equatable/equatable.dart';

import 'plugins.dart';
import 'transports.dart';

class JanusInfo with EquatableMixin {
  JanusInfo({this.plugins, this.transports, this.version});

  final Plugins? plugins;
  final Transports? transports;
  final String? version;

  @override
  List<Object?> get props => [plugins, transports, version];

  @override
  bool get stringify => true;
}
