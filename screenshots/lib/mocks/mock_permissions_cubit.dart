import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockPermissionsCubit extends MockCubit<PermissionsState> implements PermissionsCubit {
  MockPermissionsCubit();

  factory MockPermissionsCubit.initial() {
    final mock = MockPermissionsCubit();
    whenListen(
      mock,
      const Stream<PermissionsState>.empty(),
      initialState: const PermissionsState(
        initialRequestCompleted: false,
      ),
    );
    return mock;
  }
}
