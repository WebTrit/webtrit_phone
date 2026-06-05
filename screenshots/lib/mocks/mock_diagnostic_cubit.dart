import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/diagnostic/bloc/diagnostic_cubit.dart';
import 'package:webtrit_phone/features/settings/features/diagnostic/models/permission_with_status.dart';
import 'package:webtrit_phone/features/settings/features/diagnostic/models/push_token_status.dart';

class _FakePermissionWithStatus extends Fake implements PermissionWithStatus {}

class MockDiagnosticCubit extends MockCubit<DiagnosticState> implements DiagnosticCubit {
  MockDiagnosticCubit();

  factory MockDiagnosticCubit.initial() {
    final mock = MockDiagnosticCubit();
    whenListen(
      mock,
      const Stream<DiagnosticState>.empty(),
      initialState: DiagnosticState(
        pushTokenStatus: PushTokenStatus(token: 'fcm-token-demo-1234567890', type: PushTokenStatusType.success),
      ),
    );
    // The screen calls these (fetchStatuses on app-lifecycle change, the others on tap);
    // they return Future<void>, so an unstubbed-mock null would fail the cast.
    registerFallbackValue(_FakePermissionWithStatus());
    when(() => mock.fetchStatuses()).thenAnswer((_) async {});
    when(() => mock.openAppSettings()).thenAnswer((_) async {});
    when(() => mock.handleRequestPermission(any())).thenAnswer((_) async {});
    return mock;
  }
}
