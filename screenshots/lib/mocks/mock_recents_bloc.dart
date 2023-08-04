import 'package:bloc_test/bloc_test.dart';

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
        recents: dRecents,
        filter: RecentsVisibilityFilter.all,
      ),
    );
    return mock;
  }
}
