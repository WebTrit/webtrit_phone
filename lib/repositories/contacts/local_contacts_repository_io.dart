import 'dart:async';
import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:webtrit_phone/models/models.dart';

import 'local_contacts_repository.dart';

const _phoneV2Mimetype = 'vnd.android.cursor.item/phone_v2';
const _googleAccountType = 'com.google';

class LocalContactsRepository implements ILocalContactsRepository {
  LocalContactsRepository() {
    _controller = StreamController<List<LocalContact>>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  late StreamController<List<LocalContact>> _controller;
  late int _listenedCounter;
  StreamSubscription<void>? _databaseSubscription;

  @override
  Future<bool> requestPermission() async {
    final status = await FlutterContacts.permissions.request(PermissionType.readWrite);
    return status == PermissionStatus.granted || status == PermissionStatus.limited;
  }

  @override
  Stream<List<LocalContact>> contacts() {
    return _controller.stream;
  }

  @override
  Future<void> load() async {
    final contacts = await _listContacts();
    _controller.add(contacts);
  }

  void _onListenCallback() {
    if (_listenedCounter++ == 0) {
      _databaseSubscription = FlutterContacts.onDatabaseChange.listen(_contactDatabaseChangesListener);
    }
  }

  void _onCancelCallback() {
    if (--_listenedCounter == 0) {
      _databaseSubscription?.cancel();
      _databaseSubscription = null;
    }
  }

  void _contactDatabaseChangesListener(void _) async {
    await load();
  }

  Future<List<LocalContact>> _listContacts() async {
    final contacts = await FlutterContacts.getAll(
      properties: {
        ContactProperty.name,
        ContactProperty.phone,
        ContactProperty.email,
        ContactProperty.photoThumbnail,
        if (Platform.isAndroid) ContactProperty.identifiers,
      },
    );
    return contacts
        .where((contact) {
          if (contact.id == null) return false;
          if (!Platform.isAndroid) return true;
          // Hides synthetic raw_contacts created by messaging apps (WhatsApp, Viber, Telegram).
          // Why: pass if any raw_contact has a phone_v2 data row (real telephony entry) OR
          // belongs to a Google account (WT-432: Android 12+ Google contacts may lack phone_v2).
          final rawContacts = contact.android?.identifiers?.rawContacts ?? const [];
          if (rawContacts.isEmpty) return true;
          return rawContacts.any(
            (rc) => rc.dataMimetypes.contains(_phoneV2Mimetype) || rc.account?.type == _googleAccountType,
          );
        })
        .map(
          (contact) => LocalContact(
            id: contact.id!,
            displayName: contact.displayName,
            firstName: contact.name?.first,
            lastName: contact.name?.last,
            thumbnail: contact.photo?.thumbnail,
            phones: contact.phones
                .map(
                  (phone) => LocalContactPhone(
                    number: phone.number,
                    label: phone.label.label == PhoneLabel.custom
                        ? (phone.label.customLabel ?? '')
                        : phone.label.label.name,
                  ),
                )
                .toList(),
            emails: contact.emails
                .map(
                  (email) => LocalContactEmail(
                    address: email.address,
                    label: email.label.label == EmailLabel.custom
                        ? (email.label.customLabel ?? '')
                        : email.label.label.name,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }
}
