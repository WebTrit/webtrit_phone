import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/diagnostic/bloc/network_tester_cubit.dart';

class MockNetworkTesterCubit extends MockCubit<NetworkTesterState> implements NetworkTesterCubit {
  MockNetworkTesterCubit();

  factory MockNetworkTesterCubit.initial() {
    final mock = MockNetworkTesterCubit();
    whenListen(mock, const Stream<NetworkTesterState>.empty(), initialState: const NetworkTesterState());
    when(() => mock.refresh()).thenAnswer((_) async {});
    return mock;
  }
}
