import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/data/data.dart';

class MockRecentsBloc extends MockBloc<RecentsEvent, RecentsState> implements RecentsBloc {
  MockRecentsBloc();

  factory MockRecentsBloc.mainScreen() {
    final mock = MockRecentsBloc();
    whenListen(
      mock,
      const Stream<RecentsState>.empty(),
      initialState: RecentsState(
        recents: dMockRecentCallHistory,
        filter: RecentsVisibilityFilter.all,
      ),
    );
    when(() => mock.dateFormat).thenReturn(DateFormat.yMMMd().add_Hm());
    return mock;
  }
}
