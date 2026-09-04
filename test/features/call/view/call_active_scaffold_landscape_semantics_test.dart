import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';

import '../../../helpers/helpers.dart';
import 'call_active_scaffold_harness.dart';

/// What the landscape arrangement offers to assistive technology: the controls
/// that exist only there - the isolated hangup and the hide-keypad under it -
/// must announce themselves and activate through semantics, not just under a
/// pointer (docs/accessibility.md).
void main() {
  late MockCallBloc callBloc;

  setUp(() {
    callBloc = newCallBloc();
    final view = TestWidgetsFlutterBinding.instance.platformDispatcher.views.single;
    view.physicalSize = const Size(2622, 1206);
    view.devicePixelRatio = 3;
    addTearDown(view.reset);
  });

  final active = makeCall(callId: 'active', acceptedTime: DateTime(2024), displayName: 'Boris Klein');

  testWidgets('the isolated hangup announces itself and ends the call through semantics', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));

    final node = tester.getSemantics(find.bySemanticsIdentifier(callActionsHangupId));
    expect(node.getSemanticsData().label, isNotEmpty);

    await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsHangupId));
    verify(() => callBloc.add(const CallControlEvent.ended('active'))).called(1);

    handle.dispose();
    await teardownCallScaffold(tester);
  });

  testWidgets('the hide-keypad under the hangup announces itself and closes the keypad through semantics', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(buildCallScaffold(callBloc, activeCalls: [active], focusedCall: active));

    await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsKeypadId));
    await tester.pumpAndSettle();
    expect(find.byType(KeypadKeyButton), findsNWidgets(12));

    final node = tester.getSemantics(find.bySemanticsIdentifier(callActionsHideKeypadId));
    expect(node.getSemanticsData().label, isNotEmpty);

    await tapViaSemantics(tester, find.bySemanticsIdentifier(callActionsHideKeypadId));
    await tester.pumpAndSettle();
    expect(find.byType(KeypadKeyButton), findsNothing);

    handle.dispose();
    await teardownCallScaffold(tester);
  });
}
