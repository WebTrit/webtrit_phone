import 'package:equatable/equatable.dart';

class SipPresenceConfig extends Equatable {
  const SipPresenceConfig({
    required this.hybridPresenceSupport,
    required this.dialogsViaSipBlfSupport,
    required this.presenceViaSipSupport,
  });

  final bool hybridPresenceSupport;

  final bool dialogsViaSipBlfSupport;

  final bool presenceViaSipSupport;

  bool get subsSyncEnabled => hybridPresenceSupport && (dialogsViaSipBlfSupport || presenceViaSipSupport);

  @override
  List<Object?> get props => [hybridPresenceSupport, dialogsViaSipBlfSupport, presenceViaSipSupport];
}
