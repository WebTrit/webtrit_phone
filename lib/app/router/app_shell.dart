import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'app_router.dart';

@RoutePage()
class AppShell extends StatelessWidget {
  const AppShell({super.key});

  // Map scopes to their associated routes
  static const Map<NotificationScope, List<String>> _scopeRoutes = {
    NotificationScope.login: [LoginRouterPageRoute.name],
    NotificationScope.main: [MainScreenPageRoute.name, SettingsScreenPageRoute.name],
    NotificationScope.call: [CallScreenPageRoute.name],
  };

  @override
  Widget build(BuildContext context) {
    return Provider<DiagnosticService>(
      create: (context) => _createDiagnosticService(context),
      dispose: (_, service) => service.dispose(),
      child: MultiBlocListener(
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
                      context.showSnackBar(lastNotification.l10n(context), action: lastNotification.action(context));
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
      ),
    );
  }

  DiagnosticService _createDiagnosticService(BuildContext context) {
    final appPermissions = context.read<AppPermissions>();
    final diagnostics = AndroidCallkeepUtils.diagnostics;

    return DiagnosticServiceImpl(
      strategies: [AndroidCallkeepDiagnosticStrategy(appPermissions: appPermissions, callkeepDiagnostics: diagnostics)],
      dialogLauncher: () =>
          showDialog<DiagnosticReportOptions>(context: context, builder: (_) => const DiagnosticReportDialog()),
    );
  }
}
