import 'package:clock/clock.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/call_direction.dart';
import 'package:webtrit_phone/models/dialog_info.dart';

final dAudioActiveCall = ActiveCall(
  line: 0,
  callId: '123',
  handle: const CallkeepHandle(type: CallkeepHandleType.number, value: 'Thomas Anderson'),
  direction: CallDirection.incoming,
  video: false,
  createdTime: clock.ago(minutes: 10),
  acceptedTime: clock.ago(minutes: 9, seconds: 41),
  processingStatus: CallProcessingStatus.connected,
);

final dVideoActiveCall = ActiveCall(
  line: 0,
  callId: '123',
  handle: const CallkeepHandle(type: CallkeepHandleType.number, value: 'Thomas Anderson'),
  direction: CallDirection.incoming,
  video: false,
  createdTime: clock.ago(minutes: 10),
  acceptedTime: clock.ago(minutes: 9, seconds: 41),
  processingStatus: CallProcessingStatus.connected,
);

/// A confirmed call on another device, enough for the call pull badge to
/// appear in the app bar and offer taking the call over.
final dPullableCallDialogs = [
  DialogInfo(
    id: 'dialog-001',
    entityNumber: '1234',
    state: DialogState.confirmed,
    callId: 'call-pull-001',
    direction: DialogDirection.initiator,
    localTag: 'local-tag-001',
    localNumber: '555001',
    localDisplayName: 'Annete Black',
    remoteTag: 'remote-tag-001',
    remoteNumber: '1234',
    remoteDisplayName: 'Thomas Anderson',
    arrivalVersion: '1',
    arrivalTime: clock.ago(minutes: 1),
  ),
];
