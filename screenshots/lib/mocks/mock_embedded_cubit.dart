import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/embedded/bloc/embedded_cubit.dart';

class MockEmbeddedCubit extends MockCubit<EmbeddedState> implements EmbeddedCubit {
  MockEmbeddedCubit();

  factory MockEmbeddedCubit.mainScreen() {
    final mock = MockEmbeddedCubit();
    whenListen(
      mock,
      const Stream<EmbeddedState>.empty(),
      initialState: const EmbeddedState.initial(),
    );
    return mock;
  }
}
