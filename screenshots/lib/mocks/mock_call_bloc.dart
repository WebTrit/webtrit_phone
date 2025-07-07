import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/data/data.dart';

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {
  MockCallBloc();

  factory MockCallBloc.mainScreen() {
    final mock = MockCallBloc();
    whenListen(
      mock,
      const Stream<CallState>.empty(),
      initialState: const CallState(
        callServiceState: CallServiceState(
          signalingClientStatus: SignalingClientStatus.connect,
        ),
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
        callServiceState: CallServiceState(
          signalingClientStatus: SignalingClientStatus.connect,
        ),
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
        callServiceState: const CallServiceState(
          signalingClientStatus: SignalingClientStatus.connect,
        ),
        activeCalls: [
          if (video) dVideoActiveCall else dAudioActiveCall,
        ],
        speaker: false,
      ),
    );
    return mock;
  }
}
