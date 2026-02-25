import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/settings/features/diagnostic/bloc/diagnostic_cubit.dart';
import 'package:webtrit_phone/features/settings/features/diagnostic/models/push_token_status.dart';

class MockDiagnosticCubit extends MockCubit<DiagnosticState> implements DiagnosticCubit {
  MockDiagnosticCubit();

  factory MockDiagnosticCubit.initial() {
    final mock = MockDiagnosticCubit();
    whenListen(
      mock,
      const Stream<DiagnosticState>.empty(),
      initialState: DiagnosticState(
        pushTokenStatus: PushTokenStatus(
          token: 'fcm-token-demo-1234567890',
          type: PushTokenStatusType.success,
        ),
      ),
    );
    return mock;
  }
}
