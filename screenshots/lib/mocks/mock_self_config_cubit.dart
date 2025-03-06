import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:webtrit_phone/models/self_config.dart';

class MockSelfConfigCubit extends MockCubit<SelfConfigState> implements SelfConfigCubit {
  MockSelfConfigCubit();

  // Factory to create an initial mock instance with the default state
  factory MockSelfConfigCubit.initial() {
    final mock = MockSelfConfigCubit();
    whenListen(
      mock,
      const Stream<SelfConfigState>.empty(),
      initialState: SelfConfigState(),
    );
    return mock;
  }

  // Factory to create a mock instance with a predefined SelfConfig
  factory MockSelfConfigCubit.withConfig(SelfConfig selfConfig) {
    final mock = MockSelfConfigCubit();
    whenListen(
      mock,
      const Stream<SelfConfigState>.empty(),
      initialState: SelfConfigState(selfConfig: selfConfig),
    );
    return mock;
  }

  // Factory to create a mock instance that throws an error on fetchSelfConfig
  factory MockSelfConfigCubit.withError() {
    final mock = MockSelfConfigCubit();
    whenListen(
      mock,
      const Stream<SelfConfigState>.empty(),
      initialState: SelfConfigState(),
    );

    // Simulate error behavior during fetchSelfConfig
    when(() => mock.fetchSelfConfig()).thenAnswer((_) async {
      throw Exception('Failed to fetch self config');
    });

    return mock;
  }

  // Mock method for fetchSelfConfig to allow customization in tests
  @override
  Future<void> fetchSelfConfig() {
    return super.noSuchMethod(
      Invocation.method(#fetchSelfConfig, []),
    );
  }
}
