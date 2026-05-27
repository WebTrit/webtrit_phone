import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:webtrit_phone/models/models.dart';

import 'local_contacts_repository.dart';

// Filter values passed to FlutterContacts.getAll. The plugin combines them
// with OR semantics: a contact passes if it has at least one data row with
// _phoneV2Mimetype OR at least one raw contact in _googleAccountType.
// Mirrors the 1.x filter behavior. Android-only — iOS ignores both
// parameters via the androidXxx naming.
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
      properties: {ContactProperty.name, ContactProperty.phone, ContactProperty.email, ContactProperty.photoThumbnail},
      androidRequiredDataMimetypes: const {_phoneV2Mimetype},
      androidRequiredAccountTypes: const {_googleAccountType},
    );
    return contacts
        .where((contact) => contact.id != null)
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
