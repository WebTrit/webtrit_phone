import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class MockMediaSettingsCubit extends MockCubit<MediaSettingsState> implements MediaSettingsCubit {
  MockMediaSettingsCubit();

  factory MockMediaSettingsCubit.settingsScreen() {
    final mock = MockMediaSettingsCubit();
    whenListen(
      mock,
      const Stream<MediaSettingsState>.empty(),
      initialState: MediaSettingsState(
        encodingSettings: EncodingSettings.blank(),
        encodingPreset: null,
        audioProcessingSettings: AudioProcessingSettings.blank(),
        videoCapturingSettings: VideoCapturingSettings.blank(),
        iceSettings: IceSettings.blank(),
        pearConnectionSettings:
            PeerConnectionSettings(negotiationSettings: NegotiationSettings(includeInactiveVideoInOfferAnswer: false)),
      ),
    );
    return mock;
  }
}
