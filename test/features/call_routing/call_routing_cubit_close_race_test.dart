import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../mocks/fake_connectivity_service.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockLinesStateRepository extends Mock implements LinesStateRepository {}

class MockCallerIdSettingsRepository extends Mock implements CallerIdSettingsRepository {}

/// A connectivity check the test completes by hand, so the cubit can be closed
/// while its initialization is still parked on the `await`.
class HandCompletedConnectivityService extends FakeConnectivityService {
  final completer = Completer<bool>();

  @override
  Future<bool> checkConnection() => completer.future;
}

void main() {
  // The cubit subscribes to the combined user/lines stream only AFTER an
  // awaited connectivity check. If the cubit is closed while that await is
  // pending, the subscription must not be created (or must be torn down):
  // otherwise it keeps feeding emit() on a closed cubit forever - the
  // "Cannot emit new states after calling close" spam seen in the field.
  test(
    'closing during initialization leaves no subscription that emits after close',
    () async {
      final connectivity = HandCompletedConnectivityService();

      final userController = StreamController<UserInfo>.broadcast();
      final userRepository = MockUserRepository();
      when(() => userRepository.getAndListen()).thenAnswer((_) => userController.stream);

      final linesController = StreamController<LinesState>.broadcast();
      final linesStateRepository = MockLinesStateRepository();
      when(() => linesStateRepository.getStateAndListen()).thenAnswer((_) => linesController.stream);

      final cubit = CallRoutingCubit(
        userRepository,
        linesStateRepository,
        MockCallerIdSettingsRepository(),
        connectivity,
      );

      // Close while _init is still awaiting the connectivity check...
      await cubit.close();
      // ...then let the check complete on the already-closed cubit.
      connectivity.completer.complete(true);
      await pumpEventQueue();

      // Feed the streams the subscription would listen to. On a correctly
      // torn-down cubit nothing happens; on the broken one emit() throws
      // StateError into the test zone and fails this test.
      userController.add(UserInfo(numbers: Numbers()));
      linesController.add(LinesState.blank());
      await pumpEventQueue();

      expect(cubit.isClosed, isTrue);

      await userController.close();
      await linesController.close();
    },
    skip: 'WT-1845: red until the emit-after-close leak is fixed; unskip in the fix PR',
  );
}
