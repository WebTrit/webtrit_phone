import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/data/data.dart';

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {
  MockSettingsBloc();

  factory MockSettingsBloc.settingsScreen() {
    final mock = MockSettingsBloc();
    whenListen(
      mock,
      const Stream<SettingsState>.empty(),
      initialState: const SettingsState(
        info: userInfo,
      ),
    );
    return mock;
  }
}
