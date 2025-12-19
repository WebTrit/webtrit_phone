import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/contact/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  group('ContactDisplayExtension', () {
    Contact createContact({List<ContactPhone> phones = const [], int id = 1, bool favorite = false}) {
      return Contact(id: id, sourceType: ContactSourceType.local, phones: phones);
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
  });
}
