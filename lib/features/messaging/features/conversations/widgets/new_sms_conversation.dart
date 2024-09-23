import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/features/messaging/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

final _logger = Logger('NewSmsConversation');

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
  final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
  late final StreamSubscription contactsSub;
  String? simCountryCode;

  bool initializing = true;
  List<Contact> localContacts = [];
  List<Contact> externalContacts = [];
  String searchFilterValue = '';
  PhoneNumber? customNumber;

  @override
  void initState() {
    super.initState();
    contactsSub = widget.contactsRepository.watchContacts('').asyncMap(
      (contacts) async {
        return compute((contacts) {
          return contacts.where((contact) {
            contact.phones.removeWhere((number) => !number.number.isValidPhone);
            return contact.phones.isNotEmpty;
          }).toList();
        }, contacts);
      },
    ).listen((contacts) {
      final filtered = contacts.where(widget.filter).toList();
      setState(() {
        initializing = false;
        localContacts = filtered.where((contact) => contact.sourceType == ContactSourceType.local).toList();
        externalContacts = filtered.where((contact) => contact.sourceType == ContactSourceType.external).toList();
      });
    });

    FlutterSimCountryCode.simCountryCode.then(
      (value) {
        _logger.info('SimCountryCode: $value');
        if (mounted) setState(() => simCountryCode = value);
      },
      onError: (e) {
        _logger.warning('Error getting simCountryCode: $e');
      },
    );
  }

  @override
  void dispose() {
    contactsSub.cancel();
    super.dispose();
  }

  onConfirm(String selectedNumber, String? participantId) {
    // Navigator.of(context).pop((selectedNumber.e164Phone!, participantId));
    Navigator.of(context).pop((selectedNumber, participantId));
  }

  onCreateByNumber() {
    final number = phoneUtil.format(customNumber!, PhoneNumberFormat.e164);
    Navigator.of(context).pop((number, null));
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
    if (searchFilterValue.isEmpty) return false;
    try {
      final customNumber = phoneUtil.parse(searchFilterValue, simCountryCode);
      this.customNumber = customNumber;
      return phoneUtil.isValidNumber(customNumber);
    } on NumberParseException catch (e) {
      _logger.info('NumberParseException: $e');
      return false;
    }
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
          title: Text(context.l10n.messaging_NewConversation_title),
          automaticallyImplyLeading: false,
          leading: TextButton(
            onPressed: onCancel,
            child: Text(
              context.l10n.messaging_NewConversation_cancel,
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
          leadingWidth: 100,
          actions: [
            if (isNumberInField)
              TextButton(
                onPressed: onCreateByNumber,
                child: Text(
                  context.l10n.messaging_NewConversation_create,
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
                  hintText: context.l10n.messaging_NewConversation_contactOrNumberSearch_hint,
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
            if (initializing)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else
              Flexible(
                child: ListView(
                  children: [
                    if (externalContactsToShow.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          context.l10n.messaging_NewConversation_externalContacts_heading,
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
                          context.l10n.messaging_NewConversation_localContacts_heading,
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

    final userId = contact.sourceType == ContactSourceType.external ? contact.sourceId : null;

    if (contact.phones.length > 1) {
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
          children: contact.phones.map((number) {
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
      subtitle: Text(contact.phones.first.number, style: theme.textTheme.bodySmall),
      onTap: () => onConfirm(contact.phones.first.number, userId),
    );
  }
}

bool _defaultFilter(Contact contact) => contact.canSendSms;
