import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {
  MockSessionStatusCubit();

  factory MockSessionStatusCubit.initial() {
    final mock = MockSessionStatusCubit();
    whenListen(mock, const Stream<SessionStatusState>.empty(), initialState: const SessionStatusState());
    return mock;
  }

  /// A connected session: the app bar shows its title instead of the
  /// "Connecting..." caption and renders the ready-only actions (the call pull
  /// badge, the system notifications bell).
  factory MockSessionStatusCubit.ready() {
    final mock = MockSessionStatusCubit();
    whenListen(
      mock,
      const Stream<SessionStatusState>.empty(),
      initialState: const SessionStatusState(status: SessionStatus(signalingStatus: CallStatus.ready)),
    );
    return mock;
  }
}
