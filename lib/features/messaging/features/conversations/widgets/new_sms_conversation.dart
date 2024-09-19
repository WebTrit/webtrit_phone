import 'dart:async';

import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class NewSmsConversation extends StatefulWidget {
  const NewSmsConversation({
    required this.contactsRepository,
    this.filter = _defaultFilter,
    super.key,
  });

  final ContactsRepository contactsRepository;
  final bool Function(Contact) filter;

  @override
  State<NewSmsConversation> createState() => _NewSmsConversationState();
}

class _NewSmsConversationState extends State<NewSmsConversation> {
  late final StreamSubscription contactsSub;

  List<Contact> localContacts = [];
  List<Contact> externalContacts = [];
  String searchFilterValue = '';

  @override
  void initState() {
    super.initState();
    contactsSub = widget.contactsRepository.watchContacts('').listen((contacts) {
      final filtered = contacts.where(widget.filter).toList();
      setState(() {
        localContacts = filtered.where((contact) => contact.sourceType == ContactSourceType.local).toList();
        externalContacts = filtered.where((contact) => contact.sourceType == ContactSourceType.external).toList();
      });
    });
  }

  @override
  void dispose() {
    contactsSub.cancel();
    super.dispose();
  }

  onConfirm(String number, String? participantId) {
    Navigator.of(context).pop((number, participantId));
  }

  onCancel() {
    Navigator.of(context).pop();
  }

  List<Contact> searchFilter(List<Contact> contacts) {
    return searchFilterValue.isEmpty
        ? contacts
        : contacts.where((contact) => contact.name.toLowerCase().contains(searchFilterValue)).toList();
  }

  bool get isNumberInField {
    if (searchFilterValue.length < 6) return false;
    final matchInter = matches(searchFilterValue, r'^\+?[0-9]+$');
    final matchLocal = matches(searchFilterValue, r'^[0-9]+$');
    return matchInter || matchLocal;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final localContactsToShow = searchFilter(localContacts);
    final externalContactsToShow = searchFilter(externalContacts);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.chats_NewConversation_title),
          automaticallyImplyLeading: false,
          leading: TextButton(
            onPressed: onCancel,
            child: Text(
              context.l10n.chats_NewConversation_cancel,
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
          leadingWidth: 100,
          actions: [
            if (isNumberInField)
              TextButton(
                onPressed: () => onConfirm(searchFilterValue, null),
                child: Text(
                  context.l10n.chats_NewConversation_create,
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.l10n.chats_NewConversation_contactOrNumberSearch_hint,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) => setState(() => searchFilterValue = value.toLowerCase()),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                children: [
                  if (externalContactsToShow.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        context.l10n.chats_NewConversation_externalContacts_heading,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 8)
                  ],
                  ...externalContactsToShow.map((Contact contact) {
                    return tileBuilder(contact);
                  }),
                  const SizedBox(height: 8),
                  if (localContactsToShow.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        context.l10n.chats_NewConversation_localContacts_heading,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 8)
                  ],
                  ...localContactsToShow.map((Contact contact) {
                    return tileBuilder(contact);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tileBuilder(Contact contact) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final numbers = contact.phones.where((number) => number.label != 'ext').toList();
    final userId = contact.sourceType == ContactSourceType.external ? contact.sourceId : null;

    if (numbers.length > 1) {
      return Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
          highlightColor: colorScheme.primary.withOpacity(0.1),
        ),
        child: ExpansionTile(
          leading: LeadingAvatar(
            username: contact.name,
            thumbnail: contact.thumbnail,
            thumbnailUrl: contact.thumbnailUrl,
            registered: contact.registered,
            radius: 24,
          ),
          title: Text(contact.name),
          children: numbers.map((number) {
            return ListTile(
              title: Text(number.number),
              onTap: () => onConfirm(number.number, userId),
            );
          }).toList(),
        ),
      );
    }

    return ListTile(
      leading: LeadingAvatar(
        username: contact.name,
        thumbnail: contact.thumbnail,
        thumbnailUrl: contact.thumbnailUrl,
        registered: contact.registered,
        radius: 24,
      ),
      title: Text(contact.name),
      onTap: () => onConfirm(numbers.first.number, userId),
    );
  }
}

bool _defaultFilter(Contact contact) => contact.canSendSms;
