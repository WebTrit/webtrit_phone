import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {
  MockCallRoutingCubit();

  /// Null state (default).
  factory MockCallRoutingCubit.initial() {
    final mock = MockCallRoutingCubit();
    whenListen(mock, const Stream<CallRoutingState?>.empty(), initialState: null);
    return mock;
  }

  /// Provide any prebuilt state without touching private constructors.
  factory MockCallRoutingCubit.withState(CallRoutingState state) {
    final mock = MockCallRoutingCubit();
    whenListen(mock, const Stream<CallRoutingState?>.empty(), initialState: state);
    return mock;
  }

  /// Emit a sequence of states (useful for UI reacting to updates).
  factory MockCallRoutingCubit.sequence({
    required List<CallRoutingState?> states,
  }) {
    assert(states.isNotEmpty, 'states cannot be empty');
    final mock = MockCallRoutingCubit();
    whenListen(
      mock,
      Stream<CallRoutingState?>.fromIterable(states.skip(1)),
      initialState: states.first,
    );
    return mock;
  }
}
