import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../chat_conversation_builder.dart';

class GroupContactsSelectionView extends StatelessWidget {
  const GroupContactsSelectionView(this.state, {super.key});

  final ChatCBGroupContactsSelection state;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final builderCubit = context.read<ChatConversationBuilderCubit>();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  context.l10n.messaging_ConversationBuilders_invite_heading,
                  style: TextStyle(color: colorScheme.secondary.withValues(alpha: 0.7), fontSize: 16),
                ),
              ),
              ...state.selectedContacts.map((contact) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LeadingAvatar(
                        username: contact.displayTitle,
                        thumbnail: contact.thumbnail,
                        thumbnailUrl: contact.thumbnailUrl,
                        registered: contact.registered,
                        radius: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(contact.displayTitle, style: TextStyle(color: colorScheme.secondary, fontSize: 12)),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                context.l10n.messaging_ConversationBuilders_externalContacts_heading,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: context.l10n.messaging_ConversationBuilders_contactSearch_hint,
              fillColor: colorScheme.surface,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) => builderCubit.onSearchFilterChange(value),
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: ListView(
            children: state.filteredContacts.map((Contact contact) {
              final selected = state.selectedContacts.contains(contact);
              return GestureDetector(
                onTap: () => selected
                    ? builderCubit.onGroupContactDeselected(contact)
                    : builderCubit.onGroupContactSelected(contact),
                child: Row(
                  children: [
                    AbsorbPointer(
                      child: Checkbox(
                        value: selected,
                        shape: const CircleBorder(),
                        onChanged: (_) {},
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        leading: LeadingAvatar(
                          username: contact.displayTitle,
                          thumbnail: contact.thumbnail,
                          thumbnailUrl: contact.thumbnailUrl,
                          registered: contact.registered,
                        ),
                        title: Text(contact.displayTitle),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
