import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {
  MockUserInfoCubit();

  /// A loaded account: the avatar shows the person rather than the placeholder the
  /// bar draws while the request is still out.
  factory MockUserInfoCubit.of(UserInfo userInfo) {
    final mock = MockUserInfoCubit();
    whenListen(mock, const Stream<UserInfoState>.empty(), initialState: UserInfoState(userInfo: userInfo));
    return mock;
  }

  factory MockUserInfoCubit.initial() {
    final mock = MockUserInfoCubit();
    whenListen(mock, const Stream<UserInfoState>.empty(), initialState: const UserInfoState());
    return mock;
  }
}
