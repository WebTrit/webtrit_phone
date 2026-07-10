import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockFullRecentCdrsCubit extends MockCubit<CdrsListState> implements FullRecentCdrsCubit {
  MockFullRecentCdrsCubit();

  factory MockFullRecentCdrsCubit.mainScreen() {
    final mock = MockFullRecentCdrsCubit();
    whenListen(mock, const Stream<CdrsListState>.empty(), initialState: CdrsListState());
    return mock;
  }

  factory MockFullRecentCdrsCubit.withCdrs() {
    final mock = MockFullRecentCdrsCubit();
    whenListen(
      mock,
      const Stream<CdrsListState>.empty(),
      initialState: CdrsListState(records: dMockCdrRecords, isLoading: false),
    );
    return mock;
  }
}
