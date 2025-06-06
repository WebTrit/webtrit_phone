import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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

  void markAsSeen(SystemNotification notification) {
    cubit.markAsSeen(notification);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.l10n.system_notifications_screen_title),
        backgroundColor: theme.canvasColor.withAlpha(150),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: theme.canvasColor.withAlpha(150)),
          ),
        ),
      ),
      body: BlocBuilder<SystemNotificationsScreenCubit, SystemNotificationScreenState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.notifications.isEmpty) {
            return Center(child: Text(context.l10n.system_notifications_screen_list_empty));
          }

          return ScrollToBottomOverlay(
            scrolledAway: scrolledAway,
            onScrollToBottom: scrollToBottom,
            child: ListView.builder(
              controller: scrollController,
              reverse: true,
              cacheExtent: 500,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, bottom: 16),
              itemCount: state.notifications.length + 1,
              itemBuilder: (context, index) {
                final historyIndicatorPosition = state.notifications.length;
                if (index == historyIndicatorPosition) return HistoryFetchIndicator(state.fetchingHistory);
                final notifiaction = state.notifications[index];
                final pendingSeen = state.outboxEntries.hasSeen(notifiaction.id);

                return FadeIn(
                  child: SizedBox(
                    key: Key(notifiaction.id.toString()),
                    child: SystemNotificationListTile(
                      notifiaction,
                      seenPending: pendingSeen,
                      onSeen: () => markAsSeen(notifiaction),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
