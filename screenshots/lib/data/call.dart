import 'package:clock/clock.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

final dAudioActiveCall = ActiveCall(
  line: 0,
  callId: '123',
  handle: const CallkeepHandle(
    type: CallkeepHandleType.number,
    value: 'Thomas Anderson',
  ),
  direction: CallDirection.incoming,
  video: false,
  createdTime: clock.ago(minutes: 10),
  acceptedTime: clock.ago(minutes: 9, seconds: 41),
  processingStatus: CallProcessingStatus.connected,
);

final dVideoActiveCall = ActiveCall(
  line: 0,
  callId: '123',
  handle: const CallkeepHandle(
    type: CallkeepHandleType.number,
    value: 'Thomas Anderson',
  ),
  direction: CallDirection.incoming,
  video: true,
  createdTime: clock.ago(minutes: 10),
  acceptedTime: clock.ago(minutes: 9, seconds: 41),
  processingStatus: CallProcessingStatus.connected,
);
