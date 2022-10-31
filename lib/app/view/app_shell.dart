import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            final lastNotification = state.lastNotification;
            if (lastNotification != null) {
              context.showErrorSnackBar(
                lastNotification.l10n(context),
                action: lastNotification.action(context),
              );
              context.read<NotificationsBloc>().add(const NotificationsCleared());
            }
          },
        ),
      ],
      child: child,
    );
  }
}
