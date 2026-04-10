import 'package:equatable/equatable.dart';

/// Configuration for the SIP presence feature.
class SipPresenceConfig extends Equatable {
  const SipPresenceConfig({required this.sipPresenceSupport});

  /// Whether the SIP presence feature is enabled and supported by the remote system.
  final bool sipPresenceSupport;

  @override
  List<Object?> get props => [sipPresenceSupport];
}
