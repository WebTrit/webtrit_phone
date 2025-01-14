import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockRegisterStatusCubit extends MockCubit<RegisterStatus> implements RegisterStatusCubit {
  MockRegisterStatusCubit();

  factory MockRegisterStatusCubit.initial(RegisterStatus initialStatus) {
    final mock = MockRegisterStatusCubit();
    whenListen(
      mock,
      const Stream<RegisterStatus>.empty(),
      initialState: initialStatus,
    );
    return mock;
  }
}
