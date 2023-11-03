import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockAuthOtpRequestCubit extends MockCubit<OtpRequestState> implements OtpRequestCubit {
  MockAuthOtpRequestCubit();

  factory MockAuthOtpRequestCubit.loginScreen() {
    final mock = MockAuthOtpRequestCubit();
    whenListen(
      mock,
      const Stream<OtpRequestState>.empty(),
      initialState: const OtpRequestState(
        demo: true,
      ),
    );
    return mock;
  }
}
