import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/voicemail/cubits/cubits.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockVoicemailRepository extends Mock implements VoicemailRepository {}

void main() {
  late StreamController<int> counts;
  late _MockVoicemailRepository repository;

  setUp(() {
    counts = StreamController<int>();
    repository = _MockVoicemailRepository();
    when(() => repository.watchUnreadVoicemailsCount()).thenAnswer((_) => counts.stream);
  });

  tearDown(() => counts.close());

  VoicemailUnreadCubit createCubit() => VoicemailUnreadCubit(repository: repository)..init();

  group('VoicemailUnreadCubit', () {
    test('answers zero until the repository says otherwise', () {
      expect(createCubit().state, 0);
    });

    test('follows the count the repository reports', () async {
      final cubit = createCubit();
      final emitted = <int>[];
      cubit.stream.listen(emitted.add);

      counts
        ..add(3)
        ..add(1);
      await pumpEventQueue();

      expect(emitted, [3, 1]);
      expect(cubit.state, 1);
    });

    test('stays quiet when the count is unchanged', () async {
      final cubit = createCubit();
      final emitted = <int>[];
      cubit.stream.listen(emitted.add);

      counts
        ..add(2)
        ..add(2);
      await pumpEventQueue();

      expect(emitted, [2]);
    });

    // Freshness belongs to the polling registration, which refreshes the
    // repository at the start of the session and every interval after. A
    // counter that fetched too would duplicate that and have to own its
    // failures.
    test('never fetches', () async {
      createCubit();
      await pumpEventQueue();

      verifyNever(() => repository.fetchVoicemails());
      verifyNever(() => repository.refresh());
    });

    test('releases the subscription when closed', () async {
      final cubit = createCubit();
      expect(counts.hasListener, isTrue);

      await cubit.close();

      expect(counts.hasListener, isFalse);
    });
  });
}
