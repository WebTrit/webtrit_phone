import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class MockCallerIdSettingsCubit extends MockCubit<CallerIdSettingsState?> implements CallerIdSettingsCubit {
  MockCallerIdSettingsCubit();

  factory MockCallerIdSettingsCubit.initial() {
    final mock = MockCallerIdSettingsCubit();
    whenListen(
      mock,
      const Stream<CallerIdSettingsState?>.empty(),
      initialState: CallerIdSettingsState(
        settings: CallerIdSettings(defaultNumber: '999', matchers: const []),
        mainNumber: '999',
        additionalNumbers: const ['+1234567890', '+0987654321'],
      ),
    );
    return mock;
  }
}
