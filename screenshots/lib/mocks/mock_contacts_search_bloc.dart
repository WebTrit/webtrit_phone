import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockContactsSearchBloc extends MockBloc<ContactsSearchEvent, String> implements ContactsSearchBloc {
  MockContactsSearchBloc();

  factory MockContactsSearchBloc.mainScreen() {
    final mock = MockContactsSearchBloc();
    whenListen(
      mock,
      const Stream<String>.empty(),
      initialState: '',
    );
    return mock;
  }
}
