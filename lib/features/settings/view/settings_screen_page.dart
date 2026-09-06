import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class SettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    final settingsFeature = context.read<FeatureAccess>().settingsConfig;

    return BlocProvider(
      create: (context) {
        return SettingsBloc(
          notificationsBloc: context.read<NotificationsBloc>(),
          appBloc: context.read<AppBloc>(),
          userRepository: context.read<UserRepository>(),
          sessionRepository: context.read(),
          appPermissions: context.read<AppPermissions>(),
        );
      },
      child: _RefreshSessionIssuesOnResume(
        child: SettingsScreen(sections: settingsFeature.sections, sessionsEnabled: settingsFeature.sessionsEnabled),
      ),
    );
  }
}

/// Re-reads the side issues that can change while the app is not looking.
///
/// The full-screen call permission is granted on a system screen, so its answer
/// only changes when the user leaves and comes back - and this is the screen
/// that reports it, right under the account status.
class _RefreshSessionIssuesOnResume extends StatefulWidget {
  const _RefreshSessionIssuesOnResume({required this.child});

  final Widget child;

  @override
  State<_RefreshSessionIssuesOnResume> createState() => _RefreshSessionIssuesOnResumeState();
}

class _RefreshSessionIssuesOnResumeState extends State<_RefreshSessionIssuesOnResume> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  void _refresh() => context.read<SessionStatusCubit>().refreshFullScreenIntentStatus();

  @override
  Widget build(BuildContext context) => widget.child;
}
