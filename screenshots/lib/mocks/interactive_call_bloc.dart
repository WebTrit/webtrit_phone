import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/data/data.dart';

/// A [CallBloc] stand-in whose mute/hold buttons actually toggle, so the call
/// screen preview reacts to input instead of staying a frozen snapshot.
///
/// Implemented as a real [Cubit] (not a mocktail mock) so `state`/`stream`/
/// `emit` behave normally; the rest of the [CallBloc]/CallkeepDelegate surface
/// is routed to [noSuchMethod] (returns null), matching the old mock behavior.
///
/// Control events are matched by equality (their concrete types are private),
/// using the known call id. Camera is intentionally not reduced — its button
/// reads `isCameraActive`, which needs real media tracks the preview lacks.
class InteractiveCallBloc extends Cubit<CallState> implements CallBloc {
  InteractiveCallBloc({required bool video})
    : _callId = (video ? dVideoActiveCall : dAudioActiveCall).callId,
      super(
        CallState(
          callServiceState: const CallServiceState(signalingClientStatus: SignalingClientStatus.connect),
          activeCalls: [if (video) dVideoActiveCall else dAudioActiveCall],
          // Built-in earpiece + speaker so the speaker toggle renders and can switch.
          audioDevice: _earpiece,
          availableAudioDevices: const [_earpiece, _speaker],
        ),
      );

  static const _earpiece = CallAudioDevice(type: CallAudioDeviceType.earpiece);
  static const _speaker = CallAudioDevice(type: CallAudioDeviceType.speaker);

  final String _callId;

  @override
  void add(CallEvent event) {
    final next = _reduce(event);
    if (next != null) emit(next);
  }

  CallState? _reduce(CallEvent event) {
    for (final value in const [true, false]) {
      if (event == CallControlEvent.setMuted(_callId, value)) {
        return state.copyWithMappedActiveCall(_callId, (call) => call.copyWith(muted: value));
      }
      if (event == CallControlEvent.setHeld(_callId, value)) {
        return state.copyWithMappedActiveCall(_callId, (call) => call.copyWith(held: value));
      }
    }
    for (final device in const [_earpiece, _speaker]) {
      if (event == CallControlEvent.audioDeviceSet(_callId, device)) {
        return state.copyWith(audioDevice: device);
      }
    }
    return null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
