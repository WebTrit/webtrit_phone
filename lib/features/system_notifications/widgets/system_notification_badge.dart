import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';

import '../system_notifications.dart';

class SystemNotificationsBadge extends StatelessWidget {
  const SystemNotificationsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemNotificationsCounterCubit, int>(
      builder: (context, unseenCount) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final hasUnread = unseenCount > 0;

        return SizedBox(
          width: kMinInteractiveDimension,
          height: kMinInteractiveDimension,
          child: ClipOval(
            child: Material(
              child: InkWell(
                onTap: () {
                  context.router.push(const SystemNotificationsPageRoute());
                },
                child: SizedBox(
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          hasUnread ? Icons.notifications : Icons.notifications_outlined,
                          color: hasUnread ? colorScheme.tertiary : colorScheme.secondary,
                        ),
                      ),
                      if (hasUnread)
                        Center(
                          child: Text(
                            unseenCount.toString(),
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
