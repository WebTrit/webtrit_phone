import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {
  MockSettingsBloc();

  factory MockSettingsBloc.settingsScreen() {
    final mock = MockSettingsBloc();
    whenListen(
      mock,
      const Stream<SettingsState>.empty(),
      initialState: SettingsState(progress: false),
    );
    return mock;
  }
}
