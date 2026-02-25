import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockContactsLocalTabBloc extends MockBloc<ContactsLocalTabEvent, ContactsLocalTabState>
    implements ContactsLocalTabBloc {
  MockContactsLocalTabBloc();

  factory MockContactsLocalTabBloc.mainScreen() {
    final mock = MockContactsLocalTabBloc();
    whenListen(
      mock,
      const Stream<ContactsLocalTabState>.empty(),
      initialState: const ContactsLocalTabState(
        status: ContactsLocalTabStatus.success,
      ),
    );
    return mock;
  }
}
