import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

bool _defaultFilter(Contact contact) => true;

class AddContactDialog extends StatefulWidget {
  const AddContactDialog({
    required this.contactsRepository,
    this.filter = _defaultFilter,
    super.key,
  });

  final ContactsRepository contactsRepository;
  final bool Function(Contact) filter;

  @override
  State<AddContactDialog> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  late final StreamSubscription contactsSub;
  List<Contact> contacts = [];

  onConfirm(Contact contact) {
    Navigator.of(context).pop(contact);
  }

  onCancel() {
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

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.chats_AddContactDialog_title, style: theme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              if (contacts.isEmpty) Text(context.l10n.chats_AddContactDialog_empty),
              if (contacts.isNotEmpty)
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: contacts.map((Contact contact) {
                      return ContactTile(
                        displayName: contact.name,
                        thumbnail: contact.thumbnail,
                        registered: contact.registered,
                        onTap: () => onConfirm(contact),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 16),
              TextButton(onPressed: onCancel, child: Text(context.l10n.chats_AddContactDialog_cancel)),
            ],
          ),
        ),
      ),
    );
  }
}
