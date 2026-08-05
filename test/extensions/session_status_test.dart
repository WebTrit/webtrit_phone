import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  late AppLocalizations l10n;

  Future<String> captionOf(
    WidgetTester tester,
    SessionStatus status, {
    required bool registered,
    bool updating = false,
  }) async {
    late String caption;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context)!;
            caption = status.subtitleL10n(context, registered: registered, updating: updating);
            return const SizedBox();
          },
        ),
      ),
    );
    return caption;
  }

  testWidgets('a session the user turned off names that reason', (tester) async {
    const status = SessionStatus(signalingStatus: CallStatus.appUnregistered);

    expect(await captionOf(tester, status, registered: false), l10n.sessionStatus_subtitle_registrationOff);
  });

  testWidgets('an unregistered session the user did not ask for points to diagnostics instead', (tester) async {
    const status = SessionStatus(signalingStatus: CallStatus.appUnregistered);

    expect(await captionOf(tester, status, registered: true), l10n.sessionStatus_subtitle_diagnostic);
  });

  testWidgets('re-registering after the toggle flips on reads as progress, not as a fault', (tester) async {
    const status = SessionStatus(signalingStatus: CallStatus.appUnregistered);

    expect(await captionOf(tester, status, registered: true, updating: true), l10n.sessionStatus_subtitle_inProgress);
  });

  testWidgets('a missing network names the network, not the account', (tester) async {
    const status = SessionStatus(signalingStatus: CallStatus.connectivityNone);

    expect(await captionOf(tester, status, registered: true), l10n.sessionStatus_subtitle_connectivityNone);
  });

  testWidgets('a push token problem outranks the signaling status', (tester) async {
    const status = SessionStatus(signalingStatus: CallStatus.ready, pushTokenError: 'boom');

    expect(await captionOf(tester, status, registered: true), l10n.sessionStatus_subtitle_diagnostic);
  });

  test('only a missing network or a session still connecting rule out a server request', () {
    expect(const SessionStatus(signalingStatus: CallStatus.ready).mayReachServer, isTrue);
    expect(const SessionStatus(signalingStatus: CallStatus.appUnregistered).mayReachServer, isTrue);
    // Signaling-channel problems do not: the settings travel over HTTP
    // independently of the signaling socket.
    expect(const SessionStatus(signalingStatus: CallStatus.connectError).mayReachServer, isTrue);
    expect(const SessionStatus(signalingStatus: CallStatus.connectIssue).mayReachServer, isTrue);
    expect(const SessionStatus(signalingStatus: CallStatus.connectivityNone).mayReachServer, isFalse);
    expect(const SessionStatus(signalingStatus: CallStatus.inProgress).mayReachServer, isFalse);
  });
}
