import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/utils/contact_resolver.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/contacts/contacts_repository.dart';
import 'package:webtrit_phone/repositories/user_info/user_repository.dart';

class _MockContactsRepository extends Mock implements ContactsRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

Contact _contact(String alias) =>
    Contact(id: 1, sourceType: ContactSourceType.external, kind: ContactKind.visible, aliasName: alias);

UserInfo _userInfo({String? ext, String? main, List<String>? additional, String? alias, String? first, String? last}) =>
    UserInfo(
      numbers: Numbers(ext: ext, main: main, additional: additional),
      aliasName: alias,
      firstName: first,
      lastName: last,
    );

void main() {
  late _MockContactsRepository contactsRepository;
  late _MockUserRepository userRepository;
  late DefaultContactResolver resolver;

  setUp(() {
    contactsRepository = _MockContactsRepository();
    userRepository = _MockUserRepository();
    // Default: no cached user info, so resolve() always falls through to the repository.
    when(() => userRepository.getLocalInfo()).thenReturn(null);
    resolver = DefaultContactResolver(contactsRepository: contactsRepository, userRepository: userRepository);
  });

  group('DefaultContactResolver.resolve', () {
    test('returns the contact when the repository finds one', () async {
      when(() => contactsRepository.getContactByPhoneNumber('4')).thenAnswer((_) async => _contact('Dima4'));

      final contact = await resolver.resolve('4');

      expect(contact, isNotNull);
      expect(contact!.maybeName, 'Dima4');
    });

    test('returns null when the repository finds no contact', () async {
      when(() => contactsRepository.getContactByPhoneNumber('4')).thenAnswer((_) async => null);

      expect(await resolver.resolve('4'), isNull);
    });

    test('returns null and does not query for a null number', () async {
      expect(await resolver.resolve(null), isNull);
      verifyNever(() => contactsRepository.getContactByPhoneNumber(any()));
    });

    test('returns null and does not query for an empty number', () async {
      expect(await resolver.resolve(''), isNull);
      verifyNever(() => contactsRepository.getContactByPhoneNumber(any()));
    });

    test('swallows repository errors and returns null', () async {
      when(() => contactsRepository.getContactByPhoneNumber('4')).thenThrow(Exception('db failure'));

      expect(await resolver.resolve('4'), isNull);
    });
  });

  group('DefaultContactResolver.resolve - self-call (own number)', () {
    test('own EXT returns null and does NOT resolve the local phonebook contact', () async {
      when(() => userRepository.getLocalInfo()).thenReturn(_userInfo(ext: '3', main: '111000333', alias: 'Dima3'));
      // A local phonebook contact also exists for the own number - it must NOT win.
      when(() => contactsRepository.getContactByPhoneNumber('3')).thenAnswer((_) async => _contact('Local Contact'));

      expect(await resolver.resolve('3'), isNull);
      verifyNever(() => contactsRepository.getContactByPhoneNumber(any()));
    });

    test('own MAIN number returns null', () async {
      when(() => userRepository.getLocalInfo()).thenReturn(_userInfo(ext: '3', main: '111000333', alias: 'Dima3'));

      expect(await resolver.resolve('111000333'), isNull);
    });

    test('own ADDITIONAL number returns null', () async {
      when(
        () => userRepository.getLocalInfo(),
      ).thenReturn(_userInfo(ext: '3', additional: ['777', '888'], alias: 'Dima3'));

      expect(await resolver.resolve('888'), isNull);
    });

    test('non-own number falls through to the repository', () async {
      when(() => userRepository.getLocalInfo()).thenReturn(_userInfo(ext: '3', main: '111000333', alias: 'Dima3'));
      when(() => contactsRepository.getContactByPhoneNumber('4')).thenAnswer((_) async => _contact('Dima4'));

      expect((await resolver.resolve('4'))?.maybeName, 'Dima4');
    });
  });
}
