import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'contacts_tab_harness.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockContactsBloc extends MockBloc<ContactsEvent, ContactsState> implements ContactsBloc {}

/// What the favourites list asks the database for, and what it keeps.
void main() {
  final anna = buildListContact(id: 1, name: 'Anna', favoriteNumber: true);
  final bob = buildListContact(id: 2, name: 'Bob');

  late MockContactsRepository contactsRepository;
  late MockContactsBloc searchBloc;

  setUp(() {
    contactsRepository = MockContactsRepository();
    searchBloc = MockContactsBloc();
    when(() => searchBloc.state).thenReturn(const ContactsState(sourceType: ContactSourceType.external));
  });

  ContactsFavoritesTabBloc build() =>
      ContactsFavoritesTabBloc(contactsRepository: contactsRepository, contactsSearchBloc: searchBloc);

  void withContacts(String search, List<Contact> contacts) {
    when(() => contactsRepository.watchContacts(search)).thenAnswer((_) => Stream.value(contacts));
  }

  blocTest<ContactsFavoritesTabBloc, ContactsFavoritesTabState>(
    'keeps the people with a favourite among their numbers and drops the rest',
    setUp: () => withContacts('', [anna, bob]),
    build: build,
    act: (bloc) => bloc.add(const ContactsFavoritesTabStarted(search: '')),
    expect: () => [
      isA<ContactsFavoritesTabState>()
          .having((s) => s.status, 'status', ContactsFavoritesTabStatus.success)
          .having((s) => s.contacts, 'contacts', [anna])
          .having((s) => s.searching, 'searching', isFalse),
    ],
  );

  blocTest<ContactsFavoritesTabBloc, ContactsFavoritesTabState>(
    'asks for every address book, not for one',
    // The whole point of this list: a person starred in the phone book and a
    // person starred in the extensions directory belong in the same list, and
    // asking per source is what would split them into two.
    setUp: () => withContacts('', const []),
    build: build,
    act: (bloc) => bloc.add(const ContactsFavoritesTabStarted(search: '')),
    verify: (_) {
      verify(() => contactsRepository.watchContacts('')).called(1);
      verifyNever(() => contactsRepository.watchContacts(any(), any()));
    },
  );

  blocTest<ContactsFavoritesTabBloc, ContactsFavoritesTabState>(
    'reports a search so an empty result can be told apart from an empty list',
    setUp: () => withContacts('zeb', const []),
    build: build,
    act: (bloc) => bloc.add(const ContactsFavoritesTabStarted(search: 'zeb')),
    expect: () => [
      isA<ContactsFavoritesTabState>()
          .having((s) => s.contacts, 'contacts', isEmpty)
          .having((s) => s.searching, 'searching', isTrue),
    ],
  );
}
