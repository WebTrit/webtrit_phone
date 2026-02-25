import 'package:bloc_test/bloc_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import '../data/data.dart';

class MockCallLogBloc extends MockBloc<CallLogEvent, CallLogState> implements CallLogBloc {
  MockCallLogBloc();

  factory MockCallLogBloc.withHistory() {
    final mock = MockCallLogBloc();
    whenListen(
      mock,
      const Stream<CallLogState>.empty(),
      initialState: CallLogState(
        number: '1234',
        contact: Contact(
          id: 1,
          sourceType: ContactSourceType.external,
          kind: ContactKind.visible,
          sourceId: 'user_1',
          firstName: 'Thomas',
          lastName: 'Anderson',
        ),
        callLog: dMockCallLogEntries,
      ),
    );
    when(() => mock.dateFormat).thenReturn(DateFormat.yMMMd().add_Hm());
    return mock;
  }
}
