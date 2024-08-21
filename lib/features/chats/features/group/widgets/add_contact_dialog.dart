import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:webtrit_phone/features/features.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class AddContactDialog extends StatefulWidget {
  const AddContactDialog({
    required this.contactsRepository,
    super.key,
  });

  final ContactsRepository contactsRepository;

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
      setState(() => this.contacts = contacts.where((contact) => contact.canMessage).toList());
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
              Text('Choose contact', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 16),
              if (contacts.isEmpty) const Text('No contacts found'),
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
              TextButton(onPressed: onCancel, child: const Text('Cancel')),
            ],
          ),
        ),
      ),
    );
  }
}
