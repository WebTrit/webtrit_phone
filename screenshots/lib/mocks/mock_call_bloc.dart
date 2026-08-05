import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart' show Registration, RegistrationStatus;

import 'package:screenshots/data/data.dart';

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {
  MockCallBloc();

  factory MockCallBloc.mainScreen() {
    final mock = MockCallBloc();
    whenListen(
      mock,
      const Stream<CallState>.empty(),
      initialState: const CallState(
        callServiceState: CallServiceState(signalingClientStatus: SignalingClientStatus.connect),
      ),
    );
    return mock;
  }

  factory MockCallBloc.settingsScreen() {
    final mock = MockCallBloc();
    whenListen(
      mock,
      const Stream<CallState>.empty(),
      initialState: const CallState(
        callServiceState: CallServiceState(signalingClientStatus: SignalingClientStatus.connect),
      ),
    );
    return mock;
  }

  factory MockCallBloc.callScreen(bool video) {
    final mock = MockCallBloc();
    whenListen(
      mock,
      const Stream<CallState>.empty(),
      initialState: CallState(
        // Registered signaling -> CallStatus.ready, so the active call renders as
        // connected instead of a perpetual "Connecting..." state.
        callServiceState: const CallServiceState(
          signalingClientStatus: SignalingClientStatus.connect,
          registration: Registration(status: RegistrationStatus.registered),
        ),
        activeCalls: [if (video) dVideoActiveCall else dAudioActiveCall],
      ),
    );
    return mock;
  }
}
