import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class TabButtons extends StatefulWidget {
  const TabButtons({required this.selectedTab, required this.onTabSelected, super.key});

  final TabType selectedTab;
  final Function(TabType) onTabSelected;

  @override
  State<TabButtons> createState() => _TabButtonsState();
}

class _TabButtonsState extends State<TabButtons> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<UnreadCountCubit, UnreadCountState>(
      builder: (context, unreadCountState) {
        return TabBar(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
          controller: _tabController,
          onTap: (value) {
            widget.onTabSelected(TabType.values[value]);
          },
          tabs: [
            Tab(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' ${context.l10n.messaging_ConversationsScreen_messages_title}'),
                  if (unreadCountState.chatsWithUnreadCount > 0) ...[
                    const SizedBox(width: 4),
                    Container(
                      width: 14,
                      height: 14,
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: widget.selectedTab == TabType.chat
                            ? colorScheme.onPrimary
                            : colorScheme.onSurfaceVariant,
                        shape: BoxShape.circle,
                      ),
                      child: FittedBox(
                        child: Text(
                          unreadCountState.chatsWithUnreadCount.toString(),
                          style: TextStyle(
                            color: widget.selectedTab == TabType.chat ? colorScheme.onSurface : colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' ${context.l10n.messaging_ConversationsScreen_smses_title}'),
                  if (unreadCountState.smsConversationsWithUnreadCount > 0) ...[
                    const SizedBox(width: 4),
                    Container(
                      width: 14,
                      height: 14,
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: widget.selectedTab == TabType.sms ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                        shape: BoxShape.circle,
                      ),
                      child: FittedBox(
                        child: Text(
                          unreadCountState.smsConversationsWithUnreadCount.toString(),
                          style: TextStyle(
                            color: widget.selectedTab == TabType.sms ? colorScheme.onSurface : colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          indicatorSize: TabBarIndicatorSize.tab,
          splashBorderRadius: BorderRadius.circular(8),
        );
      },
    );
  }
}
