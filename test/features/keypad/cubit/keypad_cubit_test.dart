import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/utils/contact_resolver.dart';
import 'package:webtrit_phone/features/keypad/keypad.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockContactResolver extends Mock implements ContactResolver {}

Contact _contact(String alias) =>
    Contact(id: 1, sourceType: ContactSourceType.external, kind: ContactKind.visible, aliasName: alias);

void main() {
  late _MockContactResolver resolver;

  setUp(() {
    resolver = _MockContactResolver();
  });

  // Past the 300ms keypad debounce window.
  const debounceWait = Duration(milliseconds: 400);

  blocTest<KeypadCubit, KeypadState>(
    'resolves the typed number through ContactResolver and emits the contact',
    build: () {
      when(() => resolver.resolve('4')).thenAnswer((_) async => _contact('Dima4'));
      return KeypadCubit(resolver);
    },
    act: (cubit) => cubit.setValue('4'),
    wait: debounceWait,
    verify: (cubit) {
      verify(() => resolver.resolve('4')).called(1);
      expect(cubit.state.contact?.maybeName, 'Dima4');
    },
  );

  blocTest<KeypadCubit, KeypadState>(
    'keeps the contact null when the resolver returns null (e.g. own number)',
    build: () {
      when(() => resolver.resolve('3')).thenAnswer((_) async => null);
      return KeypadCubit(resolver);
    },
    act: (cubit) => cubit.setValue('3'),
    wait: debounceWait,
    verify: (cubit) {
      verify(() => resolver.resolve('3')).called(1);
      expect(cubit.state.contact, isNull);
    },
  );

  blocTest<KeypadCubit, KeypadState>(
    'does not resolve when the value is cleared',
    build: () => KeypadCubit(resolver),
    act: (cubit) => cubit.setValue('   '),
    wait: debounceWait,
    verify: (_) {
      verifyNever(() => resolver.resolve(any()));
    },
  );
}
