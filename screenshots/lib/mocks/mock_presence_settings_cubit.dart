import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class MockPresenceSettingsCubit extends MockCubit<PresenceSettings> implements PresenceSettingsCubit {
  MockPresenceSettingsCubit();

  factory MockPresenceSettingsCubit.initial() {
    final mock = MockPresenceSettingsCubit();
    whenListen(
      mock,
      const Stream<PresenceSettings>.empty(),
      initialState: PresenceSettings.blank(device: 'screenshot'),
    );
    return mock;
  }
}
