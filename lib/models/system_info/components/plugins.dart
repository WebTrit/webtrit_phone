import 'package:equatable/equatable.dart';

import 'sip_version.dart';

class Plugins with EquatableMixin {
  Plugins({this.sip});

  final SipVersion? sip;

  @override
  List<Object?> get props => [sip];

  @override
  bool get stringify => true;
}
