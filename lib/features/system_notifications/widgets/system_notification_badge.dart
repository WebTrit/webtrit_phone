import 'dart:math';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../system_notifications.dart';

class SystemNotificationsBadge extends StatefulWidget {
  const SystemNotificationsBadge({super.key});

  @override
  State<SystemNotificationsBadge> createState() => _SystemNotificationsBadgeState();
}

class _SystemNotificationsBadgeState extends State<SystemNotificationsBadge> with TickerProviderStateMixin {
  late final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      if (!mounted) return false;
      final unseenCount = context.read<SystemNotificationsCounterCubit>().state;
      if (unseenCount > 0) {
        controller.repeat(max: 0.38, reverse: true, count: 4);
        await Future.delayed(Duration(seconds: 5 + Random().nextInt(10)));
      }
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: BlocBuilder<SystemNotificationsCounterCubit, int>(
        builder: (context, unseenCount) {
          final theme = Theme.of(context);
          final colorScheme = theme.colorScheme;
          final hasUnseen = unseenCount > 0;

          final title = context.l10n.system_notifications_screen_title;
          return SemanticAction.button(
            label: hasUnseen ? '$title, $unseenCount' : title,
            identifier: systemNotificationsBadgeId,
            child: SizedBox(
              width: kMinInteractiveDimension,
              height: kMinInteractiveDimension,
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.reset();
                      FocusScope.of(context).unfocus();
                      context.router.navigate(const SystemNotificationsPageRoute());
                    },
                    child: SizedBox(
                      child: Stack(
                        children: [
                          RotationTransition(
                            turns: controller.drive(
                              Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.elasticInOut)),
                            ),
                            child: Center(
                              child: Icon(
                                hasUnseen ? Icons.notifications : Icons.notifications_outlined,
                                color: hasUnseen ? colorScheme.tertiary : colorScheme.secondary,
                              ),
                            ),
                          ),
                          if (hasUnseen)
                            Center(
                              // The raw digit is visual-only; the count is
                              // spoken as part of the button's label.
                              child: ExcludeSemantics(
                                child: Text(
                                  unseenCount.toString(),
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
