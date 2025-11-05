import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockMainBloc extends MockBloc<MainBlocEvent, MainBlocState>
    implements MainBloc {
  MockMainBloc();

  factory MockMainBloc.mainScreen() {
    final mock = MockMainBloc();
    whenListen(
      mock,
      const Stream<MainBlocState>.empty(),
      initialState: MainBlocState.initial(),
    );
    return mock;
  }
}
