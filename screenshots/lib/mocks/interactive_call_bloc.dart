import 'dart:async';

import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/data/data.dart';

/// A [CallBloc] stand-in whose mute/hold buttons actually toggle, so the call
/// screen preview reacts to input instead of staying a frozen snapshot.
///
/// The concrete [CallControlEvent] subclasses are private, so they can't be
/// pattern-matched from here; events are matched by equality (Equatable) using
/// the known call id instead. Camera is intentionally not reduced — its button
/// reads `isCameraActive`, which needs real media tracks the preview lacks.
class InteractiveCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {
  InteractiveCallBloc({required bool video}) : _callId = (video ? dVideoActiveCall : dAudioActiveCall).callId {
    _current = CallState(
      callServiceState: const CallServiceState(signalingClientStatus: SignalingClientStatus.connect),
      activeCalls: [if (video) dVideoActiveCall else dAudioActiveCall],
    );
    whenListen(this, _controller.stream, initialState: _current);
  }

  final String _callId;
  final StreamController<CallState> _controller = StreamController<CallState>.broadcast();
  late CallState _current;

  @override
  void add(CallEvent event) {
    final next = _reduce(event);
    if (next != null && next != _current) {
      _current = next;
      _controller.add(next);
    }
  }

  CallState? _reduce(CallEvent event) {
    for (final value in const [true, false]) {
      if (event == CallControlEvent.setMuted(_callId, value)) {
        return _current.copyWithMappedActiveCall(_callId, (call) => call.copyWith(muted: value));
      }
      if (event == CallControlEvent.setHeld(_callId, value)) {
        return _current.copyWithMappedActiveCall(_callId, (call) => call.copyWith(held: value));
      }
    }
    return null;
  }

  @override
  Future<void> close() async {
    await _controller.close();
  }
}
