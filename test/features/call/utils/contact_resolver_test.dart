import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/utils/contact_resolver.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/contacts/contacts_repository.dart';

class _MockContactsRepository extends Mock implements ContactsRepository {}

Contact _contact(String alias) =>
    Contact(id: 1, sourceType: ContactSourceType.external, kind: ContactKind.visible, aliasName: alias);

void main() {
  late _MockContactsRepository contactsRepository;
  late DefaultContactResolver resolver;

  setUp(() {
    contactsRepository = _MockContactsRepository();
    resolver = DefaultContactResolver(contactsRepository: contactsRepository);
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
}
