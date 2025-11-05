import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockSessionStatusCubit extends MockCubit<SessionStatusState>
    implements SessionStatusCubit {
  MockSessionStatusCubit();

  factory MockSessionStatusCubit.initial() {
    final mock = MockSessionStatusCubit();
    whenListen(
      mock,
      const Stream<SessionStatusState>.empty(),
      initialState: const SessionStatusState(),
    );
    return mock;
  }
}
