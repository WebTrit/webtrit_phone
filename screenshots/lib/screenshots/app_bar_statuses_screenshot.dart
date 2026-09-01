import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/mocks/mocks.dart';

/// Every state the main app bar can be in, one under another.
///
/// The bar says two things at once - the caption or title on the left, and the ring
/// with its badges around the account avatar on the right - and both are driven by
/// states that are awkward to reach by hand on a device. Here they stand in a column,
/// each under its own caption, so a change is compared against the whole set rather
/// than against memory of one of them.
class AppBarStatusesScreenshot extends StatelessWidget {
  const AppBarStatusesScreenshot({super.key});

  static const _limitedCallMode = SessionIssue(
    id: SessionIssueId.limitedStandaloneCallMode,
    severity: SessionIssueSeverity.warning,
  );

  static const _cases = <_Case>[
    _Case('ready', 'signaling connected', SessionStatus(signalingStatus: CallStatus.ready)),
    _Case('in progress', 'connecting', SessionStatus(signalingStatus: CallStatus.inProgress)),
    _Case('connect issue', 'connected, with an issue', SessionStatus(signalingStatus: CallStatus.connectIssue)),
    _Case('connect error', 'the connection failed', SessionStatus(signalingStatus: CallStatus.connectError)),
    _Case('connectivity none', 'no network on the device', SessionStatus(signalingStatus: CallStatus.connectivityNone)),
    _Case('app unregistered', 'the app is not registered', SessionStatus(signalingStatus: CallStatus.appUnregistered)),
    _Case(
      'push token error',
      'push registration failed over a healthy session',
      SessionStatus(signalingStatus: CallStatus.ready, pushTokenError: 'registration failed'),
    ),
    _Case(
      'microphone unavailable',
      'the permission is refused; the badge hangs off the top-right',
      SessionStatus(signalingStatus: CallStatus.ready),
      microphoneGranted: false,
    ),
    _Case(
      'session issue',
      'a side issue; the badge sits at the bottom-right',
      SessionStatus(signalingStatus: CallStatus.ready),
      issues: [_limitedCallMode],
    ),
    _Case(
      'account not loaded yet',
      'the bar before the account request comes back',
      SessionStatus(signalingStatus: CallStatus.ready),
      accountLoaded: false,
    ),
    _Case(
      'everything at once',
      'a failing session, both badges, no microphone',
      SessionStatus(signalingStatus: CallStatus.connectIssue, pushTokenError: 'registration failed'),
      microphoneGranted: false,
      issues: [_limitedCallMode],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: _cases.length,
          itemBuilder: (context, index) => _Row(theCase: _cases[index]),
        ),
      ),
    );
  }
}

class _Case {
  const _Case(
    this.label,
    this.note,
    this.status, {
    this.microphoneGranted = true,
    this.issues = const [],
    this.accountLoaded = true,
  });

  final String label;
  final String note;
  final SessionStatus status;
  final bool microphoneGranted;
  final List<SessionIssue> issues;

  /// Whether the account request has come back; until it does the bar draws a
  /// placeholder avatar with a spinner over it.
  final bool accountLoaded;
}

/// One case: the caption that names it, then the bar it produces.
class _Row extends StatelessWidget {
  const _Row({required this.theCase});

  final _Case theCase;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                theCase.label.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(theCase.note, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
            ],
          ),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider<SessionStatusCubit>(
              create: (_) => MockSessionStatusCubit.of(theCase.status, issues: theCase.issues),
            ),
            BlocProvider<UserInfoCubit>(
              create: (_) => theCase.accountLoaded ? MockUserInfoCubit.of(userInfo) : MockUserInfoCubit.initial(),
            ),
            BlocProvider<MicrophoneStatusBloc>(
              create: (_) => MockMicrophoneStatusBloc.initial(isGranted: theCase.microphoneGranted),
            ),
            BlocProvider<SystemNotificationsCounterCubit>(
              create: (_) => MockSystemNotificationCounterCubit.withDefaults(),
            ),
          ],
          child: AppBarParams(
            systemNotificationsEnabled: true,
            pullableCallDialogs: const [],
            child: Builder(
              builder: (context) {
                // The bar is a PreferredSizeWidget, so it is given the height it asks
                // for and nothing under it - the page is a list of bars, not of screens.
                final bar = MainAppBar(title: Text(EnvironmentConfig.APP_NAME), context: context);

                // Outlined, because a bar drawn on a page the colour of a bar has no
                // visible edge: the frame is what says where the caption ends and the
                // thing being looked at begins.
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(height: bar.preferredSize.height, child: bar),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
