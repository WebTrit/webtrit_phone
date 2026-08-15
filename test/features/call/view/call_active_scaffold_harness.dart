/// Everything needed to put [CallActiveScaffold] on a test screen, kept out of
/// the test files so more than one of them can use it - the behaviour tests and
/// the accessibility tests look at the same screen from different angles.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call/view/call_active_scaffold.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class MockAppPermissions extends Mock implements AppPermissions {}

/// A call bloc that answers with an empty state and records what it is sent.
MockCallBloc newCallBloc() {
  final callBloc = MockCallBloc();
  when(() => callBloc.state).thenReturn(const CallState());
  return callBloc;
}

const kHandle = CallkeepHandle.number('+380991234567');

ActiveCall makeCall({
  String callId = 'call-1',
  CallDirection direction = CallDirection.incoming,
  CallProcessingStatus processingStatus = CallProcessingStatus.connected,
  bool held = false,
  DateTime? acceptedTime,
  String? displayName,
  bool videoPermissionDenied = false,
}) {
  return ActiveCall(
    callId: callId,
    direction: direction,
    line: 0,
    handle: kHandle,
    createdTime: DateTime(2024),
    video: false,
    processingStatus: processingStatus,
    held: held,
    acceptedTime: acceptedTime,
    displayName: displayName,
    videoPermissionDenied: videoPermissionDenied,
  );
}

/// A connected two-way video call - the only kind whose controls hide
/// themselves after a few idle seconds.
///
/// Both flags are getters over live media streams, so they are answered here
/// instead of being assembled out of fake tracks.
class VideoCall extends ActiveCall {
  VideoCall()
    : super(
        callId: 'video',
        direction: CallDirection.incoming,
        line: 0,
        handle: kHandle,
        createdTime: DateTime(2024),
        video: true,
        processingStatus: CallProcessingStatus.connected,
        acceptedTime: DateTime(2024),
        displayName: 'Anna Marchenko',
      );

  @override
  bool get isCameraActive => true;

  @override
  bool get remoteVideo => true;
}

/// How visible the block that holds every call control currently is: 1 while it
/// is on screen, 0 once it has hidden itself.
///
/// Pass [of] to measure the block around something other than the action grid -
/// a ringing call has no grid, its buttons are the incoming ones.
double controlsOpacity(WidgetTester tester, {Finder? of}) {
  final within = of ?? find.byType(ActiveCallActions);
  final opacity = find.ancestor(of: within, matching: find.byType(AnimatedOpacity));
  return tester.widget<AnimatedOpacity>(opacity.first).opacity;
}

/// The hangup control stands for the whole block below - they hide and come
/// back together.
final hangupControl = find.bySemanticsIdentifier(callActionsHangupId);

/// The controls a screen reader can reach, in the order it would step through
/// them.
///
/// Hiding the block draws it at zero opacity, and that drops the whole subtree
/// out of this list while every widget stays where it was - so a widget finder
/// proves nothing about it, and these tests read the traversal instead.
Iterable<String> reachableControls(WidgetTester tester) =>
    tester.semantics.simulatedAccessibilityTraversal().map((node) => node.getSemanticsData().identifier);

Widget buildCallScaffold(
  CallBloc callBloc, {
  required List<ActiveCall> activeCalls,
  required ActiveCall focusedCall,
  AppPermissions? appPermissions,
  bool keepControlsVisible = false,
}) {
  Widget scaffold = BlocProvider<CallBloc>.value(
    value: callBloc,
    child: CallActiveScaffold(
      callStatus: CallStatus.ready,
      activeCalls: activeCalls,
      focusedCall: focusedCall,
      audioDevice: null,
      availableAudioDevices: const [],
      callConfig: const CallCapabilitiesConfig(),
      localePlaceholderBuilder: null,
      remotePlaceholderBuilder: null,
      keepControlsVisible: keepControlsVisible,
    ),
  );
  // Only the camera permission-denied tap reads AppPermissions; provide it on demand.
  if (appPermissions != null) {
    scaffold = Provider<AppPermissions>.value(value: appPermissions, child: scaffold);
  }
  return ThemeProvider(
    settings: const ThemeSettings(),
    lightDynamic: null,
    darkDynamic: null,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // No router in the harness: hide the AutoRouter-backed back button.
      theme: ThemeData(
        extensions: [CallScreenStyles(primary: CallScreenStyle(appBar: const AppBarStyle(showBackButton: false)))],
      ),
      home: scaffold,
    ),
  );
}

/// Disposes the scaffold (cancelling its periodic probe timer) and flushes the
/// one-shot interaction-debounce timer so the test ends with no pending timers.
Future<void> teardownCallScaffold(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 3));
}
