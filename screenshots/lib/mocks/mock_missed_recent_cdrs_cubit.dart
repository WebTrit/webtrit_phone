import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import '../data/data.dart';

class MockMissedRecentCdrsCubit extends MockCubit<MissedRecentCdrsState> implements MissedRecentCdrsCubit {
  MockMissedRecentCdrsCubit();

  factory MockMissedRecentCdrsCubit.withRecords() {
    final mock = MockMissedRecentCdrsCubit();
    whenListen(
      mock,
      const Stream<MissedRecentCdrsState>.empty(),
      initialState: MissedRecentCdrsState(
        records: dMockCdrRecords.where((r) => r.status == CdrStatus.missed).toList(),
        isLoading: false,
      ),
    );
    return mock;
  }
}
