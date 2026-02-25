import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockLogRecordsConsoleCubit extends MockCubit<LogRecordsConsoleState> implements LogRecordsConsoleCubit {
  MockLogRecordsConsoleCubit();

  factory MockLogRecordsConsoleCubit.withRecords() {
    final mock = MockLogRecordsConsoleCubit();
    whenListen(
      mock,
      const Stream<LogRecordsConsoleState>.empty(),
      initialState: const LogRecordsConsoleStateSuccess([
        '[2022-07-20 09:30:00] INFO: Application started',
        '[2022-07-20 09:30:01] INFO: Connecting to core server...',
        '[2022-07-20 09:30:02] INFO: Connected successfully',
        '[2022-07-20 09:30:05] INFO: SIP registration completed',
        '[2022-07-20 09:31:00] INFO: Incoming call from 1234',
        '[2022-07-20 09:31:01] INFO: Call accepted',
        '[2022-07-20 09:45:00] INFO: Call ended (duration: 14m)',
      ]),
    );
    return mock;
  }
}
