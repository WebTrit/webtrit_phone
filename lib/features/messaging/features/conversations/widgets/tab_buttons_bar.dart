import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class TabButtonsBar extends StatelessWidget {
  const TabButtonsBar(this.selectedTab, {required this.onChange, super.key});

  final TabType selectedTab;
  final Function(TabType) onChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tabTitleWidth = _computeTabTittleWidth(context) + 60;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        border: Border.all(color: colorScheme.secondaryFixedDim),
        borderRadius: BorderRadius.circular(9),
      ),
      child: BlocBuilder<UnreadCountCubit, UnreadCountState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                decoration: BoxDecoration(
                  color: selectedTab == TabType.chat ? colorScheme.primary : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onChange(TabType.chat),
                    child: SizedBox(
                      width: tabTitleWidth,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.messaging_ConversationsScreen_messages_title,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: selectedTab == TabType.chat ? colorScheme.onPrimary : colorScheme.onSurface,
                            ),
                          ),
                          if (state.chatsWithUnreadCount > 0) ...[
                            const SizedBox(width: 4),
                            Container(
                              width: 14,
                              height: 14,
                              padding: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: selectedTab == TabType.chat ? colorScheme.onPrimary : colorScheme.onSurface,
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(
                                child: Text(
                                  state.chatsWithUnreadCount.toString(),
                                  style: TextStyle(
                                    color: selectedTab == TabType.chat ? colorScheme.onSurface : colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                decoration: BoxDecoration(
                  color: selectedTab == TabType.sms ? colorScheme.primary : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onChange(TabType.sms),
                    child: SizedBox(
                      width: tabTitleWidth,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.messaging_ConversationsScreen_smses_title,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: selectedTab == TabType.sms ? colorScheme.onPrimary : colorScheme.onSurface,
                            ),
                          ),
                          if (state.smsConversationsWithUnreadCount > 0) ...[
                            const SizedBox(width: 4),
                            Container(
                              width: 14,
                              height: 14,
                              padding: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: selectedTab == TabType.sms ? colorScheme.onPrimary : colorScheme.onSurface,
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(
                                child: Text(
                                  state.smsConversationsWithUnreadCount.toString(),
                                  style: TextStyle(
                                    color: selectedTab == TabType.sms ? colorScheme.onSurface : colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

double _computeTabTittleWidth(BuildContext context) {
  final theme = Theme.of(context);
  final chatsText = context.l10n.messaging_ConversationsScreen_messages_title;
  final smsText = context.l10n.messaging_ConversationsScreen_smses_title;
  final longerText = chatsText.length > smsText.length ? chatsText : smsText;

  final painter = TextPainter(
    text: TextSpan(text: longerText, style: theme.textTheme.bodyMedium!),
    textDirection: TextDirection.ltr,
  )..layout();

  return painter.width;
}
