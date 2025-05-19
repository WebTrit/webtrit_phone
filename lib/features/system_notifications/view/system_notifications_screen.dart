import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/datetime.dart';
import 'package:webtrit_phone/models/system_notification.dart';

import '../system_notifications.dart';

class SystemNotificationsScreen extends StatelessWidget {
  const SystemNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Notifications'),
      ),
      body: BlocBuilder<SystemNotificationsCubit, SystemNotificationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.notifications.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return SystemNotificationTile(
                notification: notification,
                onRender: () {
                  if (notification.readAt == null) {
                    context.read<SystemNotificationsCubit>().markAsRead(notification);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

class SystemNotificationTile extends StatefulWidget {
  const SystemNotificationTile({
    required this.notification,
    this.onRender,
    super.key,
  });

  final SystemNotification notification;
  final VoidCallback? onRender;

  @override
  State<SystemNotificationTile> createState() => _SystemNotificationTileState();
}

class _SystemNotificationTileState extends State<SystemNotificationTile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onRender?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final readed = widget.notification.readAt != null;

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: readed ? colorScheme.secondaryContainer : colorScheme.tertiaryContainer,
      ),
      child: ListTile(
        minLeadingWidth: 20,
        leading: const Icon(Icons.notifications_outlined, size: 20),
        title: Text(
          widget.notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.notification.body,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Text(
          widget.notification.dateTime.timeOrDate,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
