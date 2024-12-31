import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../chat_conversation_builder.dart';

class DialogContactSelectionView extends StatelessWidget {
  const DialogContactSelectionView(this.state, {super.key});

  final ChatCBDialogContactSelection state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final builderCubit = context.read<ChatConversationBuilderCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListTile(
            title: Text(context.l10n.messaging_ConversationBuilders_createGroup),
            leading: Icon(
              Icons.group_add_rounded,
              color: colorScheme.onSurface.withValues(alpha: 0.75),
            ),
            onTap: () => builderCubit.onGroupCreateStageChoosen(),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.l10n.messaging_ConversationBuilders_externalContacts_heading,
            style: Theme.of(context).textTheme.headlineSmall,
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
              return Theme(
                data: theme.copyWith(
                  dividerColor: Colors.transparent,
                  highlightColor: colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: ListTile(
                  leading: LeadingAvatar(
                    username: contact.displayTitle,
                    thumbnail: contact.thumbnail,
                    thumbnailUrl: contact.thumbnailUrl,
                    registered: contact.registered,
                    radius: 24,
                  ),
                  title: Text(contact.displayTitle),
                  subtitle: Text('Ext: ${contact.extension ?? "N/A"}', style: theme.textTheme.bodySmall),
                  onTap: () => builderCubit.onDialogCreateConfirm(contact),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
