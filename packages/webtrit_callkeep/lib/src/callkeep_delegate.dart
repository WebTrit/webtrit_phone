import 'package:uuid/uuid.dart';

import 'callkeep.dart';
import 'callkeep_handle.dart';

abstract class CallkeepDelegate {
  void continueStartCallIntent(
    CallkeepHandle handle,
    String? displayName,
    bool video,
  );

  void didPushIncomingCall(
    CallkeepHandle handle,
    String? displayName,
    bool video,
    String callId,
    UuidValue uuid,
    CallkeepIncomingCallError? error,
  );

  Future<bool> performStartCall(
    UuidValue uuid,
    CallkeepHandle handle,
    String? displayNameOrContactIdentifier,
    bool video,
  );

  Future<bool> performAnswerCall(UuidValue uuid);

  Future<bool> performEndCall(UuidValue uuid);

  Future<bool> performSetHeld(
    UuidValue uuid,
    bool onHold,
  );

  Future<bool> performSetMuted(
    UuidValue uuid,
    bool muted,
  );

  Future<bool> performSendDTMF(
    UuidValue uuid,
    String key,
  );

  void didActivateAudioSession();

  void didDeactivateAudioSession();

  void didReset();
}
