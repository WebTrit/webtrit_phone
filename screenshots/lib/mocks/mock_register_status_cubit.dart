import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockRegisterStatusCubit extends MockCubit<RegisterStatus> implements RegisterStatusCubit {
  MockRegisterStatusCubit();

  factory MockRegisterStatusCubit.initial(bool initialValue) {
    final mock = MockRegisterStatusCubit();
    whenListen(
      mock,
      const Stream<RegisterStatus>.empty(),
      initialState: RegisterStatus(value: initialValue),
    );
    return mock;
  }
}
