import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {
  MockMicrophoneStatusBloc();

  factory MockMicrophoneStatusBloc.permissionGranted() {
    final mock = MockMicrophoneStatusBloc();
    whenListen(
      mock,
      const Stream<MicrophoneStatusState>.empty(),
      initialState: const MicrophoneStatusState(
        microphonePermissionGranted: true,
      ),
    );
    return mock;
  }

  factory MockMicrophoneStatusBloc.permissionDenied() {
    final mock = MockMicrophoneStatusBloc();
    whenListen(
      mock,
      const Stream<MicrophoneStatusState>.empty(),
      initialState: const MicrophoneStatusState(
        microphonePermissionGranted: false,
      ),
    );
    return mock;
  }

  factory MockMicrophoneStatusBloc.initial({bool isGranted = false}) {
    final mock = MockMicrophoneStatusBloc();
    whenListen(
      mock,
      const Stream<MicrophoneStatusState>.empty(),
      initialState: MicrophoneStatusState(
        microphonePermissionGranted: isGranted,
      ),
    );
    return mock;
  }
}
