import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/contact/extensions/extensions.dart';
import 'package:webtrit_phone/features/contact/models/models.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  group('ContactDisplayExtension', () {
    Contact createContact({List<ContactPhone> phones = const [], int id = 1, bool favorite = false}) {
      return Contact(id: id, sourceType: ContactSourceType.local, kind: ContactKind.visible, phones: phones);
    }

    test('should prioritize Ext over Main, and Main over Additional', () {
      final phones = [
        const ContactPhone(number: '0', label: kContactAdditionalLabel, id: 0, favorite: false),
        const ContactPhone(number: '1', label: kContactAdditionalLabel, id: 1, favorite: false),
        const ContactPhone(number: '2', label: kContactMainLabel, id: 2, favorite: false),
        const ContactPhone(number: '3', label: kContactExtLabel, id: 3, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final sorted = contact.displayPhones;

      expect(sorted[0].label, kContactExtLabel);
      expect(sorted[1].label, kContactMainLabel);
      expect(sorted[2].label, kContactAdditionalLabel);
      expect(sorted[3].label, kContactAdditionalLabel);
    });

    test('should sort "others" alphabetically', () {
      final phones = [
        const ContactPhone(number: '1', label: 'work', id: 0, favorite: false),
        const ContactPhone(number: '2', label: kContactExtLabel, id: 1, favorite: false),
        const ContactPhone(number: '3', label: 'home', id: 2, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final sorted = contact.displayPhones;

      expect(sorted[0].label, kContactExtLabel);
      expect(sorted[1].label, 'home');
      expect(sorted[2].label, 'work');
    });

    test('should keep multiple phone numbers of the same priority', () {
      final phones = [
        const ContactPhone(number: '101', label: kContactExtLabel, id: 0, favorite: false),
        const ContactPhone(number: '102', label: kContactExtLabel, id: 1, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final sorted = contact.displayPhones;

      expect(sorted.length, 2, reason: 'Must not drop duplicate priority labels');
      expect(sorted[0].number, '101');
      expect(sorted[1].number, '102');
    });

    // DID-only: same number appears with multiple labels

    test('DID-only Alice W: same number in main+sms merges into one row', () {
      // ext=1602, main=16042000002, sms=[16042000002]
      final phones = [
        const ContactPhone(number: '1602', label: kContactExtLabel, id: 0, favorite: false),
        const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 1, favorite: false),
        const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 2, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      // ext stays separate; main+sms merge into one display row
      expect(display.length, 2);
      final extRow = display.firstWhere((p) => p.number == '1602');
      expect(extRow.label, kContactExtLabel);

      final mergedRow = display.firstWhere((p) => p.number == '16042000002');
      expect(mergedRow.label, contains(kContactMainLabel));
      expect(mergedRow.label, contains(kContactSmsLabel));
    });

    test('DID-only Annet: additional+sms share one number, main+sms share another', () {
      // ext=1601, main=16042000001, additional=[99900099907], sms=[99900099907, 16042000001]
      final phones = [
        const ContactPhone(number: '1601', label: kContactExtLabel, id: 0, favorite: false),
        const ContactPhone(number: '16042000001', label: kContactMainLabel, id: 1, favorite: false),
        const ContactPhone(number: '99900099907', label: kContactAdditionalLabel, id: 2, favorite: false),
        const ContactPhone(number: '99900099907', label: kContactSmsLabel, id: 3, favorite: false),
        const ContactPhone(number: '16042000001', label: kContactSmsLabel, id: 4, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      // 3 unique numbers: 1601, 16042000001, 99900099907
      expect(display.length, 3);

      final extRow = display.firstWhere((p) => p.number == '1601');
      expect(extRow.label, kContactExtLabel);

      final mainRow = display.firstWhere((p) => p.number == '16042000001');
      expect(mainRow.label, contains(kContactMainLabel));
      expect(mainRow.label, contains(kContactSmsLabel));

      final additionalRow = display.firstWhere((p) => p.number == '99900099907');
      expect(additionalRow.label, contains(kContactAdditionalLabel));
      expect(additionalRow.label, contains(kContactSmsLabel));
    });

    test('sort order: ext first, then main, then additional, then sms-only', () {
      final phones = [
        const ContactPhone(number: '9999', label: kContactSmsLabel, id: 0, favorite: false),
        const ContactPhone(number: '2222', label: kContactAdditionalLabel, id: 1, favorite: false),
        const ContactPhone(number: '1111', label: kContactMainLabel, id: 2, favorite: false),
        const ContactPhone(number: '0000', label: kContactExtLabel, id: 3, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      expect(display.length, 4);
      expect(display[0].label, kContactExtLabel);
      expect(display[1].label, kContactMainLabel);
      expect(display[2].label, kContactAdditionalLabel);
      expect(display[3].label, kContactSmsLabel);
    });

    test('merged row is favorite if any of the grouped phones is favorite', () {
      final phones = [
        const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 0, favorite: false),
        const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 1, favorite: true),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      expect(display.length, 1);
      expect(display.first.favorite, isTrue);
    });

    test('merged row is not favorite when none of the grouped phones is favorite', () {
      final phones = [
        const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 0, favorite: false),
        const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 1, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      expect(display.length, 1);
      expect(display.first.favorite, isFalse);
    });

    test('merged row id equals the highest-priority phone id', () {
      // main (id=10) has higher priority than sms (id=20); merged row must carry id=10
      final phones = [
        const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 20, favorite: false),
        const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 10, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      expect(display.length, 1);
      expect(display.first.id, 10);
    });

    test('merged label order follows priority sort (higher priority first)', () {
      // sms has lower priority than main; label must be "number / sms", not "sms / number"
      final phones = [
        const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 1, favorite: false),
        const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 0, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      expect(display.length, 1);
      expect(display.first.label, '$kContactMainLabel / $kContactSmsLabel');
    });

    test('empty phones list returns empty display list', () {
      final contact = createContact(phones: []);

      expect(contact.displayPhones, isEmpty);
    });

    test('all phones with same number collapse into one row', () {
      final phones = [
        const ContactPhone(number: '1111', label: kContactExtLabel, id: 0, favorite: false),
        const ContactPhone(number: '1111', label: kContactMainLabel, id: 1, favorite: false),
        const ContactPhone(number: '1111', label: kContactAdditionalLabel, id: 2, favorite: false),
        const ContactPhone(number: '1111', label: kContactSmsLabel, id: 3, favorite: false),
      ];
      final contact = createContact(phones: phones);

      final display = contact.displayPhones;

      expect(display.length, 1);
      expect(display.first.number, '1111');
      expect(display.first.id, 0); // ext is highest priority
      expect(display.first.label, contains(kContactExtLabel));
    });

    group('displayPhoneEntries', () {
      test('returns ContactPhoneDisplayEntry instances', () {
        final phones = [const ContactPhone(number: '1001', label: kContactExtLabel, id: 0, favorite: false)];
        final entries = createContact(phones: phones).displayPhoneEntries;

        expect(entries, isA<List<ContactPhoneDisplayEntry>>());
        expect(entries.length, 1);
      });

      test('empty phones list returns empty entries', () {
        expect(createContact(phones: []).displayPhoneEntries, isEmpty);
      });

      test('entry.phone is the highest-priority ContactPhone', () {
        // main (id=10) has higher priority than sms (id=20)
        final phones = [
          const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 20, favorite: false),
          const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 10, favorite: false),
        ];
        final entry = createContact(phones: phones).displayPhoneEntries.first;

        expect(entry.phone.id, 10);
        expect(entry.phone.number, '16042000002');
        expect(entry.phone.label, kContactMainLabel);
      });

      test('entry.displayLabel is the merged label in priority order', () {
        final phones = [
          const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 1, favorite: false),
          const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 0, favorite: false),
        ];
        final entry = createContact(phones: phones).displayPhoneEntries.first;

        expect(entry.displayLabel, '$kContactMainLabel / $kContactSmsLabel');
      });

      test('entry.displayLabel equals phone label when there is only one phone in the group', () {
        final phones = [const ContactPhone(number: '1001', label: kContactExtLabel, id: 0, favorite: false)];
        final entry = createContact(phones: phones).displayPhoneEntries.first;

        expect(entry.displayLabel, kContactExtLabel);
      });

      test('entry.displayFavorite is true when any phone in the group is favorite', () {
        final phones = [
          const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 0, favorite: false),
          const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 1, favorite: true),
        ];
        final entry = createContact(phones: phones).displayPhoneEntries.first;

        expect(entry.displayFavorite, isTrue);
      });

      test('entry.displayFavorite is false when no phone in the group is favorite', () {
        final phones = [
          const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 0, favorite: false),
          const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 1, favorite: false),
        ];
        final entry = createContact(phones: phones).displayPhoneEntries.first;

        expect(entry.displayFavorite, isFalse);
      });

      test('entry.phone carries canonical label, not the merged displayLabel', () {
        final phones = [
          const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 1, favorite: false),
          const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 0, favorite: false),
        ];
        final entry = createContact(phones: phones).displayPhoneEntries.first;

        expect(entry.phone.label, kContactMainLabel);
        expect(entry.displayLabel, '$kContactMainLabel / $kContactSmsLabel');
        expect(entry.phone.label, isNot(equals(entry.displayLabel)));
      });

      test('unique numbers produce separate entries each with correct phone', () {
        final phones = [
          const ContactPhone(number: '1602', label: kContactExtLabel, id: 0, favorite: false),
          const ContactPhone(number: '16042000002', label: kContactMainLabel, id: 1, favorite: false),
          const ContactPhone(number: '16042000002', label: kContactSmsLabel, id: 2, favorite: false),
        ];
        final entries = createContact(phones: phones).displayPhoneEntries;

        expect(entries.length, 2);

        final extEntry = entries.firstWhere((e) => e.phone.number == '1602');
        expect(extEntry.phone.label, kContactExtLabel);
        expect(extEntry.displayLabel, kContactExtLabel);

        final mergedEntry = entries.firstWhere((e) => e.phone.number == '16042000002');
        expect(mergedEntry.phone.label, kContactMainLabel);
        expect(mergedEntry.displayLabel, '$kContactMainLabel / $kContactSmsLabel');
      });
    });
  });
}
