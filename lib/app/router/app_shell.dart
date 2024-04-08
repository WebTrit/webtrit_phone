import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            final lastNotification = state.lastNotification;
            if (lastNotification != null) {
              switch (lastNotification.type()) {
                case NotificationType.error:
                  context.showErrorSnackBar(
                    lastNotification.l10n(context),
                    action: lastNotification.action(context),
                  );
                case NotificationType.raw:
                  context.showErrorSnackBar(
                    lastNotification.l10n(context),
                    action: lastNotification.action(context),
                  );
                case NotificationType.message:
                  context.showSnackBar(
                    lastNotification.l10n(context),
                    action: lastNotification.action(context),
                  );
                case NotificationType.success:
                  context.showSuccessSnackBar(
                    lastNotification.l10n(context),
                    action: lastNotification.action(context),
                  );
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
