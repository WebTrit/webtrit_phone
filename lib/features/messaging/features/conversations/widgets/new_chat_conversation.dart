import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class NewChatConversation extends StatefulWidget {
  const NewChatConversation({
    required this.contactsRepository,
    this.filter = _defaultFilter,
    super.key,
  });

  final ContactsRepository contactsRepository;
  final bool Function(Contact) filter;

  @override
  State<NewChatConversation> createState() => _NewChatConversationState();
}

class _NewChatConversationState extends State<NewChatConversation> {
  late final StreamSubscription contactsSub;

  List<Contact> contacts = [];
  String contactsSearchFilter = '';

  @override
  void initState() {
    super.initState();
    contactsSub = widget.contactsRepository.watchContacts('', ContactSourceType.external).listen((contacts) {
      setState(() => this.contacts = contacts.where(widget.filter).toList());
    });
  }

  @override
  void dispose() {
    contactsSub.cancel();
    super.dispose();
  }

  onContactConfirm(Contact contact) {
    Navigator.of(context).pop(contact);
  }

  onNewGroupConfirm() {
    Navigator.of(context).pop(kGroupResult);
  }

  onCancel() {
    Navigator.of(context).pop();
  }

  List<Contact> get contactsFiltered {
    return contactsSearchFilter.isEmpty
        ? contacts
        : contacts.where((contact) => contact.name.toLowerCase().contains(contactsSearchFilter)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.messaging_NewConversation_title),
          leading: TextButton(
            onPressed: onCancel,
            child: Text(
              context.l10n.messaging_NewConversation_cancel,
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
          leadingWidth: 100,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                title: Text(context.l10n.messaging_NewConversation_createGroup),
                leading: Icon(
                  Icons.group_add_rounded,
                  color: colorScheme.onSurface.withOpacity(0.75),
                ),
                onTap: onNewGroupConfirm,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                context.l10n.messaging_NewConversation_externalContacts_heading,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.l10n.messaging_NewConversation_contactSearch_hint,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) => setState(() => contactsSearchFilter = value.toLowerCase()),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                children: contactsFiltered.map((Contact contact) {
                  return Theme(
                    data: theme.copyWith(
                      dividerColor: Colors.transparent,
                      highlightColor: colorScheme.primary.withOpacity(0.1),
                    ),
                    child: ListTile(
                      leading: LeadingAvatar(
                        username: contact.name,
                        thumbnail: contact.thumbnail,
                        thumbnailUrl: contact.thumbnailUrl,
                        registered: contact.registered,
                        radius: 24,
                      ),
                      title: Text(contact.name),
                      onTap: () => onContactConfirm(contact),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _defaultFilter(Contact contact) => contact.canMessage;
const kGroupResult = 'new_group';
