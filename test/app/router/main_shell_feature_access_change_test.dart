import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

import 'main_shell_harness.dart';
import '../../helpers/feature_access_factories.dart';

void main() {
  setUpAll(registerHarnessFallbacks);

  // The regression behind WT-1845: a runtime FeatureAccess update (backend
  // capability change, remote config push, or the configurator preview
  // seeding its own config) rebuilds the shell's provider layers. Conditional
  // providers change the tree's shape, the old blocs are closed - but the
  // navigator and its open screens survive and keep using the closed
  // instances. Every event they add is then swallowed silently: the call
  // button does nothing until the app is restarted.
  testWidgets('a runtime FeatureAccess update must not kill the blocs open screens use', (tester) async {
    final appTime = await AppTime.init();
    final harness = MainShellHarness(initialSupported: ['extensions']);
    addTearDown(harness.dispose);

    await tester.pumpWidget(harness.build(appTime));
    // Let the router run its guards and the shell build all layers.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // The bloc as an open screen holds it: captured once, like the keypad's
    // CallController does, and expected to stay usable for the screen's life.
    expect(find.byType(MainShell), findsOneWidget);
    // Read from below the bloc layer, the way any open screen does.
    final screenContext = tester.element(find.byType(CallShell));
    final callBlocBefore = screenContext.read<CallBloc>();
    expect(callBlocBefore.isClosed, isFalse);

    // The backend stops advertising one capability - the reactive
    // FeatureAccess stream delivers the updated configuration.
    harness.pushFeatureAccess(featureAccessFor(systemInfoWithSupported([])));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // Open screens capture the bloc once (late final fields) and keep using
    // the captured instance. If the update recreated the provider layer, the
    // screens are left holding a dead bloc: its event sink is closed, and
    // every event handed to it from now on is swallowed silently. Instance
    // identity is the observable - the dead original may even report
    // isClosed=false forever, because its shutdown awaits an event handler
    // that never completes.
    final callBlocAfter = tester.element(find.byType(CallShell)).read<CallBloc>();
    final sameInstance = identical(callBlocBefore, callBlocAfter);

    // Unmount the shell before asserting so its services cancel their timers
    // and the teardown stays clean whichever way the assertion goes.
    await tester.pumpWidget(const SizedBox.shrink());
    // Drain the one-shot delays stray watchers armed before the unmount
    // (e.g. the messaging shell's 5-second sync loop).
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(seconds: 5));
    }

    expect(
      sameInstance,
      isTrue,
      reason: 'a runtime configuration update must not replace the blocs that live screens still hold',
    );
  });
}
