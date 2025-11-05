import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

import 'call_status.dart';
import 'signaling_client_status.dart';

part 'call_service_state.freezed.dart';

enum NetworkStatus { changing, available, none }

@freezed
class CallServiceState with _$CallServiceState {
  const CallServiceState({
    this.signalingClientStatus = SignalingClientStatus.connecting,
    this.registration = const Registration(status: RegistrationStatus.registering),
    this.networkStatus,
    this.lastSignalingClientConnectError,
    this.lastSignalingClientDisconnectError,
    this.lastSignalingDisconnectCode,
  });

  @override
  final SignalingClientStatus signalingClientStatus;

  @override
  final Registration registration;

  @override
  final NetworkStatus? networkStatus;

  @override
  final Object? lastSignalingClientConnectError;

  @override
  final Object? lastSignalingClientDisconnectError;

  @override
  final int? lastSignalingDisconnectCode;

  CallStatus get status {
    final lastSignalingDisconnectCode = this.lastSignalingDisconnectCode;

    if (networkStatus == NetworkStatus.none) {
      return CallStatus.connectivityNone;
    } else if (lastSignalingClientConnectError != null) {
      return CallStatus.connectError;
    } else if (registration.status.isUnregistered) {
      return CallStatus.appUnregistered;
    } else if (registration.status.isFailed) {
      return CallStatus.connectIssue;
    } else if (lastSignalingDisconnectCode != null) {
      return CallStatus.connectIssue;
    } else if (signalingClientStatus.isConnect && registration.status.isRegistered) {
      return CallStatus.ready;
    } else {
      return CallStatus.inProgress;
    }
  }
}
