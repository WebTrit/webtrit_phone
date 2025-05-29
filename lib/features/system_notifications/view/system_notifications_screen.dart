import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/datetime.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_list_view/history_fetch_indicator.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_list_view/scroll_to_bottom.dart';

import '../system_notifications.dart';

class SystemNotificationsScreen extends StatefulWidget {
  const SystemNotificationsScreen({super.key});

  @override
  State<SystemNotificationsScreen> createState() => _SystemNotificationsScreenState();
}

class _SystemNotificationsScreenState extends State<SystemNotificationsScreen> {
  late final scrollController = ScrollController();
  late final cubit = context.read<SystemNotificationsScreenCubit>();

  bool scrolledAway = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final position = scrollController.position.pixels;
      final scrollRemaining = maxScroll - position;

      const hystoryFetchScrollThreshold = 500.0;
      final shouldFetch = scrollRemaining < hystoryFetchScrollThreshold;
      final canFetch = !cubit.state.historyEndReached && !cubit.state.fetchingHistory;
      if (shouldFetch && canFetch) cubit.fetchHistory();

      const scrolledThreshold = 1000;
      final scrolledAway = position > scrolledThreshold;
      if (this.scrolledAway != scrolledAway) setState(() => this.scrolledAway = scrolledAway);
    });
  }

  void scrollToBottom() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeInOutExpo);
  }

  void onRender(SystemNotificationViewEntry e) {
    if (e.seen == false) {
      cubit.markAsSeen(e.notification);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Notifications'),
      ),
      body: BlocBuilder<SystemNotificationsScreenCubit, SystemNotificationScreenState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.notifications.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ShaderMask(
            shaderCallback: (Rect rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black,
                ],
                stops: [0.0, 0.025, 0.975, 1.0],
              ).createShader(rect);
            },
            child: ScrollToBottomOverlay(
              scrolledAway: scrolledAway,
              onScrollToBottom: scrollToBottom,
              child: ListView.builder(
                controller: scrollController,
                reverse: true,
                cacheExtent: 500,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.notifications.length + 1,
                itemBuilder: (context, index) {
                  final entry = state.notifications[index];

                  if (index == state.notifications.length + 1) {
                    return HistoryFetchIndicator(state.fetchingHistory);
                  }

                  return SystemNotificationTile(entry, onRender: () => onRender(entry));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SystemNotificationTile extends StatefulWidget {
  const SystemNotificationTile(
    this.entry, {
    this.onRender,
    super.key,
  });

  final SystemNotificationViewEntry entry;
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
    final seen = widget.entry.seen;

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
        leading: const Icon(Icons.notifications_outlined, size: 20),
        title: Text(
          widget.entry.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.entry.content,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Text(
          widget.entry.date.timeOrDate,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
