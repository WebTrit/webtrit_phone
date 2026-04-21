import 'dart:async';

import 'package:flutter/material.dart' hide Notification;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'app_router.dart';

final _logger = Logger('AppShell');

@RoutePage()
class AppShell extends StatelessWidget {
  const AppShell({super.key});

  /// Map scopes to their associated routes.
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
      lazy: true,
      child: MultiBlocListener(
        listeners: [BlocListener<NotificationsBloc, NotificationsState>(listener: _onNotificationListener)],
        child: const AutoRouter(),
      ),
    );
  }

  void _onNotificationListener(BuildContext context, NotificationsState state) {
    if (!context.mounted) return;

    final lastNotification = state.lastNotification;
    if (lastNotification == null) return;

    final isNotificationInScope = lastNotification.scopes().any((scope) {
      final routes = _scopeRoutes[scope] ?? [];
      return routes.any((routeName) => context.router.isRouteActive(routeName));
    });

    if (isNotificationInScope) {
      _showNotificationSnackBar(context, lastNotification);
    }
    context.read<NotificationsBloc>().add(const NotificationsCleared());
  }

  void _showNotificationSnackBar(BuildContext context, Notification notification) {
    switch (notification) {
      case ErrorNotification():
      case MessageNotification():
        context.showSnackBar(notification.l10n(context), action: notification.action(context));
      case SuccessNotification():
        context.showSuccessSnackBar(notification.l10n(context), action: notification.action(context));
    }
  }

  /// Use AppShell as an entry point because I need material/router context.
  DiagnosticService _createDiagnosticService(BuildContext context) {
    final appPermissions = context.read<AppPermissions>();
    final diagnostics = AndroidCallkeepUtils.diagnostics;

    return DiagnosticServiceImpl(
      strategies: [AndroidCallkeepDiagnosticStrategy(appPermissions: appPermissions, callkeepDiagnostics: diagnostics)],
      dialogLauncher: () => _showDiagnosticDialog(context),
      rebootLauncher: () => _showSystemErrorDialog(context),
      errorLauncher: () => _showDiagnosticDialog(context),
    );
  }

  Future<DiagnosticReportOptions?> _showDiagnosticDialog(BuildContext context) async {
    /// AppShell is the root widget, so it persists for the entire app session.
    /// While a rebuild allows the context to remain valid, an unmount (e.g., app termination) invalidates it.
    /// We check `mounted` to prevent crashes in such edge cases, simply skipping the dialog if the context is detached.
    if (!context.mounted) {
      _logger.warning('Context is detached, skipping diagnostic dialog.');
      return null;
    }
    return showDialog<DiagnosticReportOptions>(context: context, builder: (_) => const DiagnosticReportDialog());
  }

  Future<void> _showSystemErrorDialog(BuildContext context) async {
    if (!context.mounted) return;
    return showDialog(context: context, builder: (_) => const SystemErrorDialog());
  }
}

class SystemErrorDialog extends StatelessWidget {
  const SystemErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.call_SystemErrorDialog_title),
      content: Text(context.l10n.call_SystemErrorDialog_description),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.l10n.alertDialogActions_ok)),
      ],
    );
  }
}
