import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockContactBloc extends MockBloc<ContactEvent, ContactState> implements ContactBloc {
  MockContactBloc();

  factory MockContactBloc.contactScreen() {
    final mock = MockContactBloc();
    whenListen(
      mock,
      const Stream<ContactState>.empty(),
      initialState: ContactState(contact: dContactsRepository.first),
    );
    return mock;
  }
}
