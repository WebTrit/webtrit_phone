import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {
  MockUserInfoCubit();

  factory MockUserInfoCubit.initial() {
    final mock = MockUserInfoCubit();
    whenListen(
      mock,
      const Stream<UserInfoState>.empty(),
      initialState: const UserInfoState(),
    );
    return mock;
  }
}
