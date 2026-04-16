import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

final _kCreatedTime = DateTime(2024, 1, 1);

CallLogEntry _makeEntry({String number = '555024', String? username}) => CallLogEntry(
  id: 1,
  direction: CallDirection.incoming,
  number: number,
  video: false,
  createdTime: _kCreatedTime,
  username: username,
);

Contact _makeContact({String? aliasName, String? firstName, String? lastName}) => Contact(
  id: 1,
  sourceType: ContactSourceType.local,
  kind: ContactKind.visible,
  aliasName: aliasName,
  firstName: firstName,
  lastName: lastName,
);

void main() {
  group('Recent.name — no contact', () {
    test('username null → falls back to number', () {
      final recent = Recent(callLogEntry: _makeEntry(username: null), contact: null);
      expect(recent.name, '555024');
    });

    test('username empty string → falls back to number', () {
      final recent = Recent(callLogEntry: _makeEntry(username: ''), contact: null);
      expect(recent.name, '555024');
    });

    test('username non-empty → returns username', () {
      final recent = Recent(callLogEntry: _makeEntry(username: 'John'), contact: null);
      expect(recent.name, 'John');
    });

    test('username whitespace-only → returns whitespace (not empty, so kept)', () {
      final recent = Recent(callLogEntry: _makeEntry(username: ' '), contact: null);
      expect(recent.name, ' ');
    });
  });

  group('Recent.name — contact with name', () {
    test('contact aliasName wins over username', () {
      final recent = Recent(
        callLogEntry: _makeEntry(username: 'John'),
        contact: _makeContact(aliasName: 'Alias'),
      );
      expect(recent.name, 'Alias');
    });

    test('contact aliasName wins even when username is empty', () {
      final recent = Recent(
        callLogEntry: _makeEntry(username: ''),
        contact: _makeContact(aliasName: 'Alias'),
      );
      expect(recent.name, 'Alias');
    });

    test('contact firstName + lastName combined', () {
      final recent = Recent(
        callLogEntry: _makeEntry(username: null),
        contact: _makeContact(firstName: 'John', lastName: 'Doe'),
      );
      expect(recent.name, 'John Doe');
    });

    test('contact firstName only', () {
      final recent = Recent(
        callLogEntry: _makeEntry(username: null),
        contact: _makeContact(firstName: 'John'),
      );
      expect(recent.name, 'John');
    });
  });

  group('Recent.name — contact without name', () {
    test('contact maybeName null + username non-empty → returns username', () {
      final recent = Recent(
        callLogEntry: _makeEntry(username: 'John'),
        contact: _makeContact(),
      );
      expect(recent.name, 'John');
    });

    test('contact maybeName null + username empty → falls back to number', () {
      final recent = Recent(
        callLogEntry: _makeEntry(username: ''),
        contact: _makeContact(),
      );
      expect(recent.name, '555024');
    });

    test('contact maybeName null + username null → falls back to number', () {
      final recent = Recent(callLogEntry: _makeEntry(username: null), contact: _makeContact());
      expect(recent.name, '555024');
    });
  });
}
