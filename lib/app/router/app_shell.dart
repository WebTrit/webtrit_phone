import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import 'app_router.dart';

@RoutePage()
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
  });

  // Map scopes to their associated routes
  static const Map<NotificationScope, List<String>> _scopeRoutes = {
    NotificationScope.login: [
      LoginRouterPageRoute.name,
    ],
    NotificationScope.main: [
      MainScreenPageRoute.name,
      SettingsScreenPageRoute.name,
    ],
    NotificationScope.call: [
      CallScreenPageRoute.name,
    ],
  };

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            final lastNotification = state.lastNotification;
            if (lastNotification != null) {
              // Check if the notification matches any active scope
              final isNotificationInScope = lastNotification.scopes().any((scope) {
                final routes = _scopeRoutes[scope] ?? [];
                return routes.any((routeName) => context.router.isRouteActive(routeName));
              });

              if (isNotificationInScope) {
                switch (lastNotification) {
                  case ErrorNotification():
                    context.showErrorSnackBar(
                      lastNotification.l10n(context),
                      action: lastNotification.action(context),
                    );
                  case MessageNotification():
                    context.showSnackBar(
                      lastNotification.l10n(context),
                      action: lastNotification.action(context),
                    );
                  case SuccessNotification():
                    context.showSuccessSnackBar(
                      lastNotification.l10n(context),
                      action: lastNotification.action(context),
                    );
                }
              }
              context.read<NotificationsBloc>().add(const NotificationsCleared());
            }
          },
        ),
      ],
      child: const AutoRouter(),
    );
  }
}
