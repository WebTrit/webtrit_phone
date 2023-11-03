import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockAuthCoreUrlAssignCubit extends MockCubit<LoginCoreUrlAssignState> implements LoginCoreUrlAssignCubit {
  MockAuthCoreUrlAssignCubit();

  factory MockAuthCoreUrlAssignCubit.loginScreen() {
    final mock = MockAuthCoreUrlAssignCubit();
    whenListen(
      mock,
      const Stream<LoginCoreUrlAssignState>.empty(),
      initialState: const LoginCoreUrlAssignState(),
    );
    return mock;
  }
}
