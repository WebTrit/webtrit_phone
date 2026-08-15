import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';

import '../../../helpers/helpers.dart';
import 'call_active_scaffold_harness.dart';

void main() {
  late MockCallBloc callBloc;

  setUp(() => callBloc = newCallBloc());

  group('CallActiveScaffold - what a screen reader is left with', () {
    // In a video call the controls hide themselves after a few idle seconds by
    // fading out, and a fully transparent block is gone from the accessibility
    // tree - hanging up, muting and going back stop existing. `CallScreen`
    // therefore demands they stay whenever a screen reader is in use.
    const idleDelay = Duration(seconds: 8);

    testWidgets('hiding them takes away the way to end the call', (tester) async {
      final semantics = tester.ensureSemantics();
      final call = VideoCall();
      await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call));

      expect(reachableControls(tester), contains(callActionsHangupId));

      await tester.pump(idleDelay);
      // They fade out rather than blink, and leave the tree only at nothing.
      await tester.pump(kThemeAnimationDuration);
      expect(reachableControls(tester), isNot(contains(callActionsHangupId)));
      await teardownCallScaffold(tester);
      semantics.dispose();
    });

    testWidgets('the demand keeps them there, named and working', (tester) async {
      final semantics = tester.ensureSemantics();
      final call = VideoCall();
      await tester.pumpWidget(
        buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call, keepControlsVisible: true),
      );

      await tester.pump(idleDelay);
      expect(reachableControls(tester), contains(callActionsHangupId));
      expectTapTargetSemantics(tester, hangupControl, label: 'Hangup', identifier: callActionsHangupId);

      // Reachable is not the same as working: activate it the way assistive
      // technology does and see the call actually end.
      await tapViaSemantics(tester, hangupControl);
      verify(() => callBloc.add(const CallControlEvent.ended('video'))).called(1);
      await teardownCallScaffold(tester);
      semantics.dispose();
    });

    testWidgets('a tap on the picture cannot take them away either', (tester) async {
      final semantics = tester.ensureSemantics();
      final call = VideoCall();
      await tester.pumpWidget(
        buildCallScaffold(callBloc, activeCalls: [call], focusedCall: call, keepControlsVisible: true),
      );

      await tester.tapAt(const Offset(20, 400));
      await tester.pump(kThemeAnimationDuration);
      expect(reachableControls(tester), contains(callActionsHangupId));
      await teardownCallScaffold(tester);
      semantics.dispose();
    });
  });
}
