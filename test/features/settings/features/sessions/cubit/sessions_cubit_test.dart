import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/sessions/cubit/sessions_cubit.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockSessionsRepository extends Mock implements SessionsRepository {}

ActiveSession _session(String id, {bool current = false}) => ActiveSession(id: id, current: current);

void main() {
  group('SessionsCubit', () {
    late _MockSessionsRepository repository;

    setUp(() {
      repository = _MockSessionsRepository();
    });

    test('fetch exposes the sessions returned by the repository', () async {
      final sessions = [_session('a', current: true), _session('b')];
      when(() => repository.getSessions()).thenAnswer((_) async => sessions);

      final cubit = SessionsCubit(repository);
      await cubit.fetch();

      expect(cubit.state.sessions, equals(sessions));
      expect(cubit.state.loading, isFalse);
      expect(cubit.state.failed, isFalse);
      await cubit.close();
    });

    test('fetch keeps the previously loaded sessions when it fails', () async {
      final sessions = [_session('a', current: true), _session('b')];
      when(() => repository.getSessions()).thenAnswer((_) async => sessions);

      final cubit = SessionsCubit(repository);
      await cubit.fetch();

      when(() => repository.getSessions()).thenThrow(Exception('offline'));
      await cubit.fetch();

      expect(cubit.state.sessions, equals(sessions));
      expect(cubit.state.failed, isTrue);
      expect(cubit.state.loading, isFalse);
      await cubit.close();
    });

    test('revoke drops the revoked session from the list', () async {
      when(() => repository.getSessions()).thenAnswer((_) async => [_session('a', current: true), _session('b')]);
      when(() => repository.revokeSession('b')).thenAnswer((_) async {});

      final cubit = SessionsCubit(repository);
      await cubit.fetch();

      final succeeded = await cubit.revoke('b');

      expect(succeeded, isTrue);
      expect(cubit.state.sessions.map((s) => s.id), equals(['a']));
      expect(cubit.state.revoking, isEmpty);
      await cubit.close();
    });

    test('revoke keeps the session and reports failure when the request fails', () async {
      when(() => repository.getSessions()).thenAnswer((_) async => [_session('a', current: true), _session('b')]);
      when(() => repository.revokeSession('b')).thenThrow(Exception('offline'));

      final cubit = SessionsCubit(repository);
      await cubit.fetch();

      final succeeded = await cubit.revoke('b');

      expect(succeeded, isFalse);
      expect(cubit.state.sessions.map((s) => s.id), equals(['a', 'b']));
      expect(cubit.state.revoking, isEmpty);
      await cubit.close();
    });

    test('revokeAllOthers revokes every session but the current one', () async {
      when(
        () => repository.getSessions(),
      ).thenAnswer((_) async => [_session('a', current: true), _session('b'), _session('c')]);
      when(() => repository.revokeSession(any())).thenAnswer((_) async {});

      final cubit = SessionsCubit(repository);
      await cubit.fetch();

      final succeeded = await cubit.revokeAllOthers();

      expect(succeeded, isTrue);
      expect(cubit.state.sessions.map((s) => s.id), equals(['a']));
      verify(() => repository.revokeSession('b')).called(1);
      verify(() => repository.revokeSession('c')).called(1);
      verifyNever(() => repository.revokeSession('a'));
      await cubit.close();
    });

    test('revokeAllOthers keeps the sessions it could not revoke', () async {
      when(
        () => repository.getSessions(),
      ).thenAnswer((_) async => [_session('a', current: true), _session('b'), _session('c')]);
      when(() => repository.revokeSession('b')).thenAnswer((_) async {});
      when(() => repository.revokeSession('c')).thenThrow(Exception('offline'));

      final cubit = SessionsCubit(repository);
      await cubit.fetch();

      final succeeded = await cubit.revokeAllOthers();

      expect(succeeded, isFalse);
      expect(cubit.state.sessions.map((s) => s.id), equals(['a', 'c']));
      await cubit.close();
    });

    test('hasOtherSessions is false when only the current session is left', () async {
      when(() => repository.getSessions()).thenAnswer((_) async => [_session('a', current: true)]);

      final cubit = SessionsCubit(repository);
      await cubit.fetch();

      expect(cubit.state.hasOtherSessions, isFalse);
      await cubit.close();
    });
  });
}
