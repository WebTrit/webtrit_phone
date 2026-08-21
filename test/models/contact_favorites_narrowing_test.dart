import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

Contact _contact({required int id, required String name, required List<(String, bool)> numbers}) => Contact(
  id: id,
  sourceType: ContactSourceType.external,
  kind: ContactKind.visible,
  firstName: name,
  phones: [
    for (final (index, (number, favorite)) in numbers.indexed)
      ContactPhone(id: id * 10 + index, number: number, label: 'main', favorite: favorite),
  ],
);

void main() {
  final anna = _contact(id: 1, name: 'Anna', numbers: [('1001', false), ('1002', true)]);
  final bob = _contact(id: 2, name: 'Bob', numbers: [('2001', false)]);
  final cara = _contact(id: 3, name: 'Cara', numbers: [('3001', true)]);
  final list = [anna, bob, cara];

  group('narrowing a contact list to favourites', () {
    test('keeps a person when any one of their numbers is a favourite', () {
      // A favourite is a number, not a person: the second number of a contact
      // has to count for them the same as the first.
      expect(list.favoritesOnly, [anna, cara]);
    });

    test('keeps the order the list already had', () {
      expect([cara, anna].favoritesOnly, [cara, anna]);
    });

    test('keeps nobody when nothing is marked', () {
      expect([bob].favoritesOnly, isEmpty);
    });

    test('an empty list narrows to an empty list', () {
      expect(<Contact>[].favoritesOnly, isEmpty);
    });
  });
}
