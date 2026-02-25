import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockVoicemailCubit extends MockCubit<VoicemailState> implements VoicemailCubit {
  MockVoicemailCubit();

  factory MockVoicemailCubit.withItems() {
    final mock = MockVoicemailCubit();
    whenListen(
      mock,
      const Stream<VoicemailState>.empty(),
      initialState: VoicemailState(
        status: VoicemailStatus.loaded,
        items: dMockVoicemails,
      ),
    );
    return mock;
  }
}
