import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:device_region/device_region.dart';
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
    this.showInvalidNumbers = true,
    super.key,
  });

  final ContactsRepository contactsRepository;
  final bool Function(Contact) filter;
  final bool showInvalidNumbers;

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
        if (widget.showInvalidNumbers) return contacts;
        return compute((contacts) {
          return contacts.where((contact) {
            contact.phones.removeWhere((number) => !number.number.isValidPhone);
            return contact.phones.isNotEmpty;
          }).toList();
        }, contacts);
      },
    ).listen((contacts) {
      final filtered = contacts.where(widget.filter).toList();
      if (!mounted) return;
      setState(() {
        initializing = false;
        localContacts = filtered.where((contact) => contact.sourceType == ContactSourceType.local).toList();
        externalContacts = filtered.where((contact) => contact.sourceType == ContactSourceType.external).toList();
      });
    });

    DeviceRegion.getSIMCountryCode().then(
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
    final isValid = selectedNumber.isValidPhone;

    if (isValid) {
      Navigator.of(context).pop((selectedNumber.e164Phone!, participantId));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: AlertDialog(
              title: Text(
                context.l10n.messaging_ConversationBuilders_invalidNumber_title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              content: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: context.l10n.messaging_ConversationBuilders_invalidNumber_message1,
                        style: const TextStyle(fontWeight: FontWeight.normal)),
                    TextSpan(
                        text: context.l10n.messaging_ConversationBuilders_numberFormatExample,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: context.l10n.messaging_ConversationBuilders_invalidNumber_message2,
                        style: const TextStyle(fontWeight: FontWeight.normal)),
                  ],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.l10n.messaging_ConversationBuilders_invalidNumber_ok),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  onCreateByNumber() {
    final number = phoneUtil.format(customNumber!, PhoneNumberFormat.e164);
    Navigator.of(context).pop((number, null));
  }

  onCancel() {
    Navigator.of(context).pop();
  }

  List<Contact> searchFiltered(List<Contact> contacts) {
    return contacts.where((contact) => _searchFilter(contact, searchFilterValue)).toList();
  }

  bool get isValidNumberInField {
    if (searchFilterValue.isEmpty) return false;
    try {
      final customNumber = phoneUtil.parse(searchFilterValue, simCountryCode?.toUpperCase());
      this.customNumber = customNumber;
      return phoneUtil.isValidNumber(customNumber);
    } catch (e) {
      _logger.info('NumberParseException: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localContactsToShow = searchFiltered(localContacts);
    final externalContactsToShow = searchFiltered(externalContacts);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Scaffold(
        appBar: appBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: field()),
            const SizedBox(height: 8),
            if (initializing)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (localContactsToShow.isEmpty && externalContactsToShow.isEmpty)
              Expanded(child: noContactsFound())
            else
              Flexible(child: contactsList(externalContactsToShow, localContactsToShow)),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(context.l10n.messaging_ConversationBuilders_title_new),
      automaticallyImplyLeading: false,
      leading: TextButton(
        onPressed: onCancel,
        child: Text(
          context.l10n.messaging_ConversationBuilders_cancel,
          style: TextStyle(color: colorScheme.primary),
        ),
      ),
      leadingWidth: 100,
      actions: [
        if (isValidNumberInField)
          TextButton(
            onPressed: onCreateByNumber,
            child: Text(
              context.l10n.messaging_ConversationBuilders_create,
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
      ],
    );
  }

  Widget contactsList(List<Contact> externalContactsToShow, List<Contact> localContactsToShow) {
    return ListView(
      children: [
        if (externalContactsToShow.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.l10n.messaging_ConversationBuilders_externalContacts_heading,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 8)
        ],
        ...externalContactsToShow.map((Contact contact) => tileBuilder(contact)),
        const SizedBox(height: 8),
        if (localContactsToShow.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.l10n.messaging_ConversationBuilders_localContacts_heading,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 8)
        ],
        ...localContactsToShow.map((Contact contact) => tileBuilder(contact)),
      ],
    );
  }

  Widget noContactsFound() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: FadeIn(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 64),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            context.l10n.messaging_ConversationBuilders_noContacts,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget field() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      decoration: InputDecoration(
        error: Builder(builder: (context) {
          final hanOnlyNumbers = searchFilterValue.length > 3 && RegExp(r'^[0-9]*$').hasMatch(searchFilterValue);

          if (hanOnlyNumbers && !isValidNumberInField) {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: context.l10n.messaging_ConversationBuilders_numberSearch_errorError,
                      style: const TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: context.l10n.messaging_ConversationBuilders_numberFormatExample,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
                style: theme.textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 13),
              ),
            );
          }

          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: context.l10n.messaging_ConversationBuilders_numberSearch_errorHint,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(
                    text: context.l10n.messaging_ConversationBuilders_numberFormatExample,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
              style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey, fontSize: 13),
            ),
          );
        }),
        hintText: context.l10n.messaging_ConversationBuilders_contactOrNumberSearch_hint,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.search),
        errorMaxLines: 3,
      ),
      onChanged: (value) => setState(() => searchFilterValue = value.toLowerCase()),
    );
  }

  Widget tileBuilder(Contact contact) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final userId = contact.sourceType == ContactSourceType.external ? contact.sourceId : null;

    var phones = contact.smsNumbers;

    if (phones.length > 1) {
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
          subtitle: Text(phones.first, style: theme.textTheme.bodySmall),
          children: phones.map((number) {
            return ListTile(
              title: Text(number),
              onTap: () => onConfirm(number, userId),
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
      subtitle: Text(phones.first, style: theme.textTheme.bodySmall),
      onTap: () => onConfirm(phones.first, userId),
    );
  }
}

bool _defaultFilter(Contact contact) => contact.canSendSms;
bool _searchFilter(Contact contact, String searchFilterValue) {
  if (searchFilterValue.isEmpty) return true;
  final matchName = contact.name.toLowerCase().contains(searchFilterValue.toLowerCase());
  final matchPhone = contact.phones.any((phone) => phone.number.contains(searchFilterValue));
  return matchName || matchPhone;
}
