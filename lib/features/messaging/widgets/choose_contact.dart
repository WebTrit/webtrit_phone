import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

bool _defaultFilter(Contact contact) => true;

class ChooseContact extends StatefulWidget {
  const ChooseContact({required this.contactsRepository, this.filter = _defaultFilter, super.key});

  final ContactsRepository contactsRepository;
  final bool Function(Contact) filter;

  @override
  State<ChooseContact> createState() => _ChooseContactState();
}

class _ChooseContactState extends State<ChooseContact> {
  late final StreamSubscription contactsSub;
  List<Contact> contacts = [];

  void onConfirm(Contact contact) {
    Navigator.of(context).pop(contact);
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.l10n.messaging_ChooseContact_title, style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        if (contacts.isEmpty) Text(context.l10n.messaging_ChooseContact_empty),
        if (contacts.isNotEmpty)
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: contacts.map((Contact contact) {
                return ListTile(
                  onTap: () => onConfirm(contact),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  leading: LeadingAvatar(
                    username: contact.displayTitle,
                    thumbnail: contact.thumbnail,
                    thumbnailUrl: contact.thumbnailUrl,
                    registered: contact.registered,
                    radius: 24,
                  ),
                  title: Text(contact.displayTitle),
                  subtitle: Text(contact.phones.firstOrNull?.number ?? ''),
                );
              }).toList(),
            ),
          ),
        const SizedBox(height: 16),
        TextButton(onPressed: onCancel, child: Text(context.l10n.messaging_ChooseContact_cancel)),
      ],
    );
  }
}
