import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/contact_source_type.dart';

class MockContactsSearchBloc extends MockBloc<ContactsEvent, ContactsState>
    implements ContactsBloc {
  MockContactsSearchBloc();

  factory MockContactsSearchBloc.mainScreen() {
    final mock = MockContactsSearchBloc();
    whenListen(
      mock,
      const Stream<ContactsState>.empty(),
      initialState: const ContactsState(
        sourceType: ContactSourceType.local,
      ),
    );
    return mock;
  }
}
