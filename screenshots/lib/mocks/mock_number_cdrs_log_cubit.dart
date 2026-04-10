import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockNumberCdrsLogCubit extends MockCubit<NumberCdrsLogState> implements NumberCdrsLogCubit {
  MockNumberCdrsLogCubit();

  factory MockNumberCdrsLogCubit.withRecords() {
    final mock = MockNumberCdrsLogCubit();
    whenListen(
      mock,
      const Stream<NumberCdrsLogState>.empty(),
      initialState: NumberCdrsLogState(
        records: dMockCdrRecords.where((r) => r.callerNumber == '1234' || r.calleeNumber == '1234').toList(),
        isLoading: false,
      ),
    );
    when(() => mock.number).thenReturn('1234');
    return mock;
  }
}
