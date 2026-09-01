import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/features/session_status/widgets/session_issue_badge.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/factory/styles/call_status_style_factory.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// One picture per state the account button in the app bar can be in, so a change to
/// the ring, the badges or the shape around them shows up as a changed picture.
///
/// The colours are the app's own: the status palette comes from the same defaults the
/// shipped themes carry, through the factory the app builds its theme with.
ThemeData _theme(Brightness brightness) {
  final colors = ColorScheme.fromSeed(seedColor: const Color(0xFF3A6FF7), brightness: brightness);

  return ThemeData(
    brightness: brightness,
    colorScheme: colors,
    extensions: [CallStatusStyleFactory(colors, const CallStatusesWidgetConfig()).create()],
  );
}

/// The ring colour states. A push token error is not a signaling state - it is layered
/// over one - so it is listed separately, with signaling healthy underneath it.
const _statuses = <String, SessionStatus>{
  'ready': SessionStatus(signalingStatus: CallStatus.ready),
  'in_progress': SessionStatus(signalingStatus: CallStatus.inProgress),
  'connect_issue': SessionStatus(signalingStatus: CallStatus.connectIssue),
  'connect_error': SessionStatus(signalingStatus: CallStatus.connectError),
  'connectivity_none': SessionStatus(signalingStatus: CallStatus.connectivityNone),
  'app_unregistered': SessionStatus(signalingStatus: CallStatus.appUnregistered),
  'push_token_error': SessionStatus(signalingStatus: CallStatus.ready, pushTokenError: 'registration failed'),
};

/// The badges the app bar hangs over the avatar, in the positions it hangs them.
Widget _microphoneOff() => const Positioned(right: -8, top: -2, child: MicrophoneOffBadge());

Widget _sessionIssue(Color color) =>
    Positioned(right: -2, bottom: -2, child: SessionIssueBadge(color: color, size: 12));

/// The avatar as the app bar builds it.
///
/// The photo is left out on purpose: a network image cannot load in a test, and what
/// these pictures are for is the ring, the badges and the shape around them, which a
/// name-derived avatar shows just as well.
Widget _frame(SessionStatus status, Brightness brightness, {List<Widget> overlays = const []}) {
  return MaterialApp(
    theme: _theme(brightness),
    home: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AppBarAvatar(
            status: status,
            semanticsLabel: 'my account',
            identifier: 'main_app_bar',
            username: 'John Doe',
            overlays: overlays,
            onPressed: () {},
          ),
        ),
      ),
    ),
  );
}

void main() {
  /// A surface the size of the button: the picture is the point of these tests, and a
  /// full test surface would be 800x600 of background around 48 px of avatar.
  void sizeToTheButton(WidgetTester tester) {
    tester.view.physicalSize = const Size(320, 320);
    tester.view.devicePixelRatio = 4;
    addTearDown(tester.view.reset);
  }

  group('AppBarAvatar', () {
    for (final brightness in Brightness.values) {
      for (final entry in _statuses.entries) {
        testWidgets('${entry.key} on ${brightness.name}', (tester) async {
          sizeToTheButton(tester);

          await tester.pumpWidget(_frame(entry.value, brightness));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(AppBarAvatar),
            matchesGoldenFile('goldens/app_bar_avatar_${entry.key}_${brightness.name}.png'),
          );
        });
      }

      testWidgets('microphone unavailable on ${brightness.name}', (tester) async {
        sizeToTheButton(tester);

        await tester.pumpWidget(
          _frame(const SessionStatus(signalingStatus: CallStatus.ready), brightness, overlays: [_microphoneOff()]),
        );
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(AppBarAvatar),
          matchesGoldenFile('goldens/app_bar_avatar_microphone_off_${brightness.name}.png'),
        );
      });

      testWidgets('session issue on ${brightness.name}', (tester) async {
        sizeToTheButton(tester);

        await tester.pumpWidget(
          _frame(
            const SessionStatus(signalingStatus: CallStatus.connectIssue),
            brightness,
            overlays: [_sessionIssue(const Color(0xFFE74C3C))],
          ),
        );
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(AppBarAvatar),
          matchesGoldenFile('goldens/app_bar_avatar_session_issue_${brightness.name}.png'),
        );
      });

      testWidgets('microphone unavailable with a session issue on ${brightness.name}', (tester) async {
        sizeToTheButton(tester);

        await tester.pumpWidget(
          _frame(
            const SessionStatus(signalingStatus: CallStatus.connectIssue, pushTokenError: 'registration failed'),
            brightness,
            overlays: [_microphoneOff(), _sessionIssue(const Color(0xFFE74C3C))],
          ),
        );
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(AppBarAvatar),
          matchesGoldenFile('goldens/app_bar_avatar_microphone_off_with_session_issue_${brightness.name}.png'),
        );
      });
    }
  });
}
