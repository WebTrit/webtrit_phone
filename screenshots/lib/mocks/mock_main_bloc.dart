import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockMainBloc extends MockBloc<MainEvent, MainState> implements MainBloc {
  MockMainBloc();

  factory MockMainBloc.mainScreen() {
    final mock = MockMainBloc();
    whenListen(
      mock,
      const Stream<MainState>.empty(),
      initialState: const MainState(),
    );
    return mock;
  }
}
