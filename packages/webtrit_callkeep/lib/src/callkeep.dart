import 'dart:async';

import 'package:uuid/uuid.dart';

import 'common/callkeep.pigeon.dart';
import 'common/converters.dart';
import 'callkeep_delegate.dart';
import 'callkeep_handle.dart';
import 'callkeep_options.dart';
import 'push_registry_delegate.dart';

enum CallkeepEndCallReason {
  failed,
  remoteEnded,
  unanswered,
  answeredElsewhere,
  declinedElsewhere,
  missed,
}

enum CallkeepIncomingCallError {
  unknown,
  unentitled,
  callUuidAlreadyExists,
  filteredByDoNotDisturb,
  filteredByBlockList,
}

enum CallkeepCallRequestError {
  unknown,
  unentitled,
  unknownCallUuid,
  callUuidAlreadyExists,
  maximumCallGroupsReached,
  internal,
}

class Callkeep {
  static final _instance = Callkeep._();

  factory Callkeep() {
    return _instance;
  }

  Callkeep._();

  final _pushRegistryApi = PPushRegistryHostApi();
  final _api = PHostApi();

  void setDelegate(CallkeepDelegate? delegate) {
    if (delegate != null) {
      PDelegateFlutterApi.setup(_CallkeepDelegateRelay(delegate));
    } else {
      PDelegateFlutterApi.setup(null);
    }
  }

  void setPushRegistryDelegate(PushRegistryDelegate? delegate) {
    if (delegate != null) {
      PPushRegistryDelegateFlutterApi.setup(_PushRegistryDelegateRelay(delegate));
    } else {
      PPushRegistryDelegateFlutterApi.setup(null);
    }
  }

  Future<String?> pushTokenForPushTypeVoIP() {
    return _pushRegistryApi.pushTokenForPushTypeVoIP();
  }

  Future<bool> isSetUp() {
    return _api.isSetUp();
  }

  Future<void> setUp(CallkeepOptions options) {
    return _api.setUp(options.toPigeon());
  }

  Future<void> tearDown() {
    return _api.tearDown();
  }

  Future<CallkeepIncomingCallError?> reportNewIncomingCall(
      UuidValue uuid, CallkeepHandle handle, String? displayName, bool hasVideo) {
    return _api
        .reportNewIncomingCall(uuid.toString(), handle.toPigeon(), displayName, hasVideo)
        .then((value) => value?.value.toCallkeep());
  }

  Future<void> reportConnectingOutgoingCall(UuidValue uuid) {
    return _api.reportConnectingOutgoingCall(uuid.toString());
  }

  Future<void> reportConnectedOutgoingCall(UuidValue uuid) {
    return _api.reportConnectedOutgoingCall(uuid.toString());
  }

  Future<void> reportUpdateCall(UuidValue uuid, CallkeepHandle? handle, String? displayName, bool? hasVideo) {
    return _api.reportUpdateCall(uuid.toString(), handle?.toPigeon(), displayName, hasVideo);
  }

  Future<void> reportEndCall(UuidValue uuid, CallkeepEndCallReason reason) {
    return _api.reportEndCall(uuid.toString(), PEndCallReason(value: reason.toPigeon()));
  }

  Future<CallkeepCallRequestError?> startCall(
      UuidValue uuid, CallkeepHandle handle, String? displayNameOrContactIdentifier, bool video) {
    return _api
        .startCall(uuid.toString(), handle.toPigeon(), displayNameOrContactIdentifier, video)
        .then((value) => value?.value.toCallkeep());
  }

  Future<CallkeepCallRequestError?> answerCall(UuidValue uuid) {
    return _api.answerCall(uuid.toString()).then((value) => value?.value.toCallkeep());
  }

  Future<CallkeepCallRequestError?> endCall(UuidValue uuid) {
    return _api.endCall(uuid.toString()).then((value) => value?.value.toCallkeep());
  }

  Future<CallkeepCallRequestError?> setHeld(UuidValue uuid, bool onHold) {
    return _api.setHeld(uuid.toString(), onHold).then((value) => value?.value.toCallkeep());
  }

  Future<CallkeepCallRequestError?> setMuted(UuidValue uuid, bool muted) {
    return _api.setMuted(uuid.toString(), muted).then((value) => value?.value.toCallkeep());
  }

  Future<CallkeepCallRequestError?> sendDTMF(UuidValue uuid, String key) {
    return _api.sendDTMF(uuid.toString(), key).then((value) => value?.value.toCallkeep());
  }
}

class _CallkeepDelegateRelay implements PDelegateFlutterApi {
  const _CallkeepDelegateRelay(this.delegate);

  final CallkeepDelegate delegate;

  @override
  void continueStartCallIntent(PHandle handle, String? displayName, bool video) {
    delegate.continueStartCallIntent(handle.toCallkeep(), displayName, video);
  }

  @override
  void didPushIncomingCall(
      PHandle handle, String? displayName, bool video, String callId, String uuidString, PIncomingCallError? error) {
    delegate.didPushIncomingCall(
        handle.toCallkeep(), displayName, video, callId, UuidValue(uuidString), error?.value.toCallkeep());
  }

  @override
  Future<bool> performStartCall(String uuidString, PHandle handle, String? displayNameOrContactIdentifier, bool video) {
    return delegate.performStartCall(UuidValue(uuidString), handle.toCallkeep(), displayNameOrContactIdentifier, video);
  }

  @override
  Future<bool> performAnswerCall(String uuidString) {
    return delegate.performAnswerCall(UuidValue(uuidString));
  }

  @override
  Future<bool> performEndCall(String uuidString) {
    return delegate.performEndCall(UuidValue(uuidString));
  }

  @override
  Future<bool> performSetHeld(String uuidString, bool onHold) {
    return delegate.performSetHeld(UuidValue(uuidString), onHold);
  }

  @override
  Future<bool> performSetMuted(String uuidString, bool muted) {
    return delegate.performSetMuted(UuidValue(uuidString), muted);
  }

  @override
  Future<bool> performSendDTMF(String uuidString, String key) {
    return delegate.performSendDTMF(UuidValue(uuidString), key);
  }

  @override
  void didActivateAudioSession() {
    delegate.didActivateAudioSession();
  }

  @override
  void didDeactivateAudioSession() {
    delegate.didDeactivateAudioSession();
  }

  @override
  void didReset() {
    delegate.didReset();
  }
}

class _PushRegistryDelegateRelay implements PPushRegistryDelegateFlutterApi {
  const _PushRegistryDelegateRelay(this.delegate);

  final PushRegistryDelegate delegate;

  @override
  void didUpdatePushTokenForPushTypeVoIP(String? token) {
    delegate.didUpdatePushTokenForPushTypeVoIP(token);
  }
}
