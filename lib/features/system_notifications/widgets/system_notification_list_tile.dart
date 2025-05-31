import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/system_notification.dart';

class SystemNotificationListTile extends StatefulWidget {
  const SystemNotificationListTile(
    this.notification, {
    this.seenPending = false,
    this.onRender,
    super.key,
  });

  final SystemNotification notification;
  final bool seenPending;
  final VoidCallback? onRender;

  @override
  State<SystemNotificationListTile> createState() => _SystemNotificationListTileState();
}

class _SystemNotificationListTileState extends State<SystemNotificationListTile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onRender?.call());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final seen = widget.notification.seen || widget.seenPending;

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: seen ? colorScheme.secondaryContainer : colorScheme.tertiaryContainer,
      ),
      child: ListTile(
        minLeadingWidth: 20,
        leading: switch (widget.notification.type) {
          SystemNotificationType.announcement => const Icon(Icons.announcement_outlined, size: 20),
          SystemNotificationType.promotion => const Icon(Icons.local_offer_outlined, size: 20),
          SystemNotificationType.security => const Icon(Icons.security_outlined, size: 20),
          SystemNotificationType.system => const Icon(Icons.settings_outlined, size: 20),
        },
        title: Text(
          widget.notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.notification.content,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Text(
          widget.notification.createdAt.timeOrDate,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
