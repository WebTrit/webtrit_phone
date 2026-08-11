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

  Future<({String title, String caption, String appBar})> textsOf(WidgetTester tester, SessionStatus status) async {
    late String title;
    late String caption;
    late String appBar;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context)!;
            title = status.l10n(context);
            caption = status.subtitleL10n(context, registered: true);
            appBar = status.appBarl10n(context);
            return const SizedBox();
          },
        ),
      ),
    );
    return (title: title, caption: caption, appBar: appBar);
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

  group('a phone system that refuses to serve the account', () {
    const refused = SessionStatus(
      signalingStatus: CallStatus.connectIssue,
      registrationRejection: RegistrationRejection.platformUnavailable,
    );

    testWidgets('is named as the service being down, not as a connection problem', (tester) async {
      final texts = await textsOf(tester, refused);

      expect(texts.title, l10n.callStatus_serviceUnavailable);
      expect(texts.appBar, l10n.sessionStatus_AppBar_serviceUnavailable);
    });

    testWidgets('tells the user their own connection is not at fault', (tester) async {
      final texts = await textsOf(tester, refused);

      expect(texts.caption, l10n.sessionStatus_subtitle_serviceUnavailable);
    });

    testWidgets('an unrecognised refusal keeps the generic wording', (tester) async {
      const status = SessionStatus(signalingStatus: CallStatus.connectIssue);

      final texts = await textsOf(tester, status);

      expect(texts.title, l10n.callStatus_connectIssue);
      expect(texts.appBar, l10n.sessionStatus_AppBar_waitingForConnection);
      expect(texts.caption, l10n.sessionStatus_subtitle_diagnostic);
    });

    // The refusal is remembered on the state, so it must not leak into a state
    // that describes something else entirely.
    testWidgets('a lost network still names the network', (tester) async {
      const status = SessionStatus(
        signalingStatus: CallStatus.connectivityNone,
        registrationRejection: RegistrationRejection.platformUnavailable,
      );

      final texts = await textsOf(tester, status);

      expect(texts.title, l10n.callStatus_connectivityNone);
      expect(texts.appBar, l10n.sessionStatus_AppBar_waitingForNetwork);
    });

    testWidgets('a transport failure still reads as a connection error', (tester) async {
      const status = SessionStatus(
        signalingStatus: CallStatus.connectError,
        registrationRejection: RegistrationRejection.platformUnavailable,
      );

      final texts = await textsOf(tester, status);

      expect(texts.title, l10n.callStatus_connectError);
      expect(texts.appBar, l10n.sessionStatus_AppBar_waitingForConnection);
    });
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
