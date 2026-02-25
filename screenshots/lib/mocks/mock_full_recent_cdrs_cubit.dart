import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockFullRecentCdrsCubit extends MockCubit<FullRecentCdrsState> implements FullRecentCdrsCubit {
  MockFullRecentCdrsCubit();

  factory MockFullRecentCdrsCubit.mainScreen() {
    final mock = MockFullRecentCdrsCubit();
    whenListen(
      mock,
      const Stream<FullRecentCdrsState>.empty(),
      initialState: FullRecentCdrsState(),
    );
    return mock;
  }

  factory MockFullRecentCdrsCubit.withCdrs() {
    final mock = MockFullRecentCdrsCubit();
    whenListen(
      mock,
      const Stream<FullRecentCdrsState>.empty(),
      initialState: FullRecentCdrsState(
        records: dMockCdrRecords,
        isLoading: false,
      ),
    );
    return mock;
  }
}
