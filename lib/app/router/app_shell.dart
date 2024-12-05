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

// TODO(Serdun): The logic here is not ideal and may result in missing important notifications.
// Consider adding a scoped mechanism to control when notifications can be displayed.
// Alternatively, create a dedicated notification page to store and display all missed notifications.
  static const _ignoreSuccessNotificationOnScreens = [
    CallScreenPageRoute.name,
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            final lastNotification = state.lastNotification;
            if (lastNotification != null) {
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
                  final shouldAllowNotification = _ignoreSuccessNotificationOnScreens.any(
                    (routeName) => !context.router.isRouteActive(routeName),
                  );

                  if (shouldAllowNotification) {
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
