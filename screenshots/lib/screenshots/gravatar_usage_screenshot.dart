import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/mocks/mocks.dart';
import 'package:screenshots/widgets/widgets.dart';

/// Where a Gravatar photo is drawn in the app, in the widget that draws it.
///
/// A url is an image cache key, so the size a place asks for decides both how sharp the
/// photo is there and whether it shares a download with the places around it. Each row
/// stands in its own surroundings - the row, the bar, the minimized-call card with its
/// shimmer - because a bare circle says nothing about how it reads in the app.
class GravatarUsageScreenshot extends StatelessWidget {
  const GravatarUsageScreenshot({super.key});

  /// The account whose photo is drawn everywhere on this page.
  static final _contact = Contact(
    id: 1,
    sourceType: ContactSourceType.local,
    kind: ContactKind.visible,
    sourceId: '1',
    firstName: userInfo.firstName,
    lastName: userInfo.lastName,
    registered: true,
    thumbnailUrl: GravatarUrl.forEmail(userInfo.email),
  );

  static final _recent = Recent(
    callLogEntry: CallLogEntry(
      id: 1,
      direction: CallDirection.incoming,
      number: '1234',
      video: false,
      createdTime: dFixedTime,
    ),
    contact: _contact,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    // The call screen sizes its avatar from the screen, the way `call_controls.dart` does.
    final callRadius = (MediaQuery.sizeOf(context).shortestSide * 0.30).clamp(24.0, 150.0);

    return Scaffold(
      // The same backdrop the status page stands on, for the same reason: these widgets
      // are frosted or drawn over video, and a plain page hides that.
      backgroundColor: Colors.transparent,
      body: MockupBackdrop(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              _Usage(
                what: 'a list row',
                where: 'recent_tile.dart, contact_tile.dart, favorite_tile.dart, cdr_tile.dart',
                radius: 20,
                devicePixelRatio: devicePixelRatio,
                child: RecentTile(recent: _recent, callNumbers: const ['1234'], dateFormat: DateFormat.Hm()),
              ),
              _Usage(
                what: 'the account button in the app bar',
                where: 'main_app_bar.dart',
                radius: 20,
                devicePixelRatio: devicePixelRatio,
                child: const _AppBar(),
              ),
              _Usage(
                what: 'the minimized call window, over its shimmer',
                where: 'call_active_thumbnail.dart',
                radius: 37,
                devicePixelRatio: devicePixelRatio,
                background: theme.colorScheme.surfaceContainerHighest,
                child: Center(
                  child: CallActiveThumbnail(
                    activeCall: dAudioActiveCall,
                    orientation: Orientation.portrait,
                    contactResolver: _FixedContactResolver(_contact),
                  ),
                ),
              ),
              _Usage(
                what: 'the call screen, where the video would be',
                where: 'call_controls.dart - 30% of the shortest side',
                radius: callRadius,
                devicePixelRatio: devicePixelRatio,
                background: theme.colorScheme.surfaceContainerHighest,
                child: Center(
                  child: CallRemoteAvatar(
                    activeCall: dAudioActiveCall,
                    radius: callRadius,
                    contactResolver: _FixedContactResolver(_contact),
                  ),
                ),
              ),
              _Usage(
                what: 'a screen header',
                where: 'contact_screen.dart, call_log_screen.dart, number_cdrs_screen.dart',
                radius: 50,
                devicePixelRatio: devicePixelRatio,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      LeadingAvatar(username: _contact.displayTitle, thumbnailUrl: _contact.thumbnailUrl, radius: 50),
                      const SizedBox(height: 12),
                      Text(_contact.displayTitle, style: theme.textTheme.headlineSmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The app bar as the app builds it, on a connected session.
class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionStatusCubit>(create: (_) => MockSessionStatusCubit.ready()),
        BlocProvider<UserInfoCubit>(create: (_) => MockUserInfoCubit.of(userInfo)),
        BlocProvider<MicrophoneStatusBloc>(create: (_) => MockMicrophoneStatusBloc.initial(isGranted: true)),
        BlocProvider<SystemNotificationsCounterCubit>(create: (_) => MockSystemNotificationCounterCubit.withDefaults()),
      ],
      child: AppBarParams(
        systemNotificationsEnabled: true,
        pullableCallDialogs: const [],
        child: Builder(
          builder: (context) {
            final bar = MainAppBar(title: Text(EnvironmentConfig.APP_NAME), context: context);

            return SizedBox(height: bar.preferredSize.height, child: bar);
          },
        ),
      ),
    );
  }
}

/// One usage: what it is, where it is written, the widget itself, and the size it asks
/// Gravatar for.
class _Usage extends StatelessWidget {
  const _Usage({
    required this.what,
    required this.where,
    required this.radius,
    required this.devicePixelRatio,
    required this.child,
    this.background,
  });

  final String what;
  final String where;
  final double radius;
  final double devicePixelRatio;
  final Widget child;

  /// What the widget is drawn on where it is not a plain surface - the call widgets sit
  /// over video or a shimmer, not over a page.
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diameter = radius * 2;
    final devicePixels = diameter * devicePixelRatio;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                what.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(where, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              Text(
                'radius ${radius.toStringAsFixed(0)} · ${diameter.toStringAsFixed(0)} dp · '
                '${devicePixels.toStringAsFixed(0)} px at ${devicePixelRatio}x → '
                's=${GravatarUrl.requestSize(devicePixels)}',
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ColoredBox(
              color: background ?? theme.colorScheme.surface,
              child: Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: child),
            ),
          ),
        ),
      ],
    );
  }
}

/// Resolves every number to the one account this page is about.
class _FixedContactResolver implements ContactResolver {
  const _FixedContactResolver(this.contact);

  final Contact contact;

  @override
  Future<Contact?> resolve(String? number) async => contact;
}
