import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockContactsExternalTabBloc
    extends MockBloc<ContactsExternalTabEvent, ContactsExternalTabState>
    implements ContactsExternalTabBloc {
  MockContactsExternalTabBloc();

  factory MockContactsExternalTabBloc.mainScreen() {
    final mock = MockContactsExternalTabBloc();
    whenListen(
      mock,
      const Stream<ContactsExternalTabState>.empty(),
      initialState: const ContactsExternalTabState(
        status: ContactsExternalTabStatus.success,
      ),
    );
    return mock;
  }
}
