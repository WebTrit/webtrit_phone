import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockAuthPasswordRequestCubit extends MockCubit<PasswordRequestState> implements PasswordRequestCubit {
  MockAuthPasswordRequestCubit();

  factory MockAuthPasswordRequestCubit.loginScreen() {
    final mock = MockAuthPasswordRequestCubit();
    whenListen(
      mock,
      const Stream<PasswordRequestState>.empty(),
      initialState: const PasswordRequestState(
        coreUrl: '',
        tenantId: '',
      ),
    );
    return mock;
  }
}
