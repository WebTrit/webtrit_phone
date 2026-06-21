import 'dart:async';
import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:webtrit_phone/models/models.dart' hide Contact;

import 'local_contacts_repository.dart';

// Hides synthetic raw_contacts created by messaging apps (WhatsApp, Viber,
// Telegram). Mirrors the 1.x `mimetypes.contains('phone_v2') OR account.type
// == 'com.google'` filter using RawContact.dataMimetypes (from the WebTrit
// fork of flutter_contacts). Android only; iOS contacts have no equivalent.
const _phoneV2Mimetype = 'vnd.android.cursor.item/phone_v2';
const _googleAccountType = 'com.google';

class LocalContactsRepository implements ILocalContactsRepository {
  LocalContactsRepository() {
    _controller = StreamController<List<LocalContact>>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
  }

  late StreamController<List<LocalContact>> _controller;
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
    _databaseSubscription = FlutterContacts.onDatabaseChange.listen((_) => load());
  }

  void _onCancelCallback() {
    _databaseSubscription?.cancel();
    _databaseSubscription = null;
  }

  /// Returns `true` for contacts that should appear in the app's contact list.
  ///
  /// Drops contacts without a stable id (can't build a [LocalContact]). On
  /// Android additionally hides synthetic raw_contacts written by messaging
  /// apps (WhatsApp, Viber, Telegram, ...) that do not carry a `phone_v2`
  /// data row and are not in a trusted account family - mirrors the 1.x
  /// `account.mimetypes.contains('phone_v2') OR account.type == 'com.google'`
  /// behaviour. Empty `rawContacts` is treated as a device-local contact and
  /// passes (some vendor ROMs do not expose account info for those).
  bool _shouldIncludeContact(Contact contact) {
    if (contact.id == null) return false;
    if (!Platform.isAndroid) return true;
    final rawContacts = contact.android?.identifiers?.rawContacts ?? const [];
    if (rawContacts.isEmpty) return true;
    return rawContacts.any(
      (rawContact) =>
          rawContact.dataMimetypes.contains(_phoneV2Mimetype) || rawContact.account?.type == _googleAccountType,
    );
  }

  /// Resolves the human-readable text for a `flutter_contacts` [Label].
  ///
  /// Returns the [Label.customLabel] (or empty string when the user did not
  /// supply one) when the enum value matches [customValue]; otherwise returns
  /// the enum's `.name`. Works for any label enum that exposes a "custom"
  /// freeform value (Phone, Email, Address, Event, ...).
  static String _resolveLabelText<T extends Enum>(Label<T> label, T customValue) =>
      label.label == customValue ? (label.customLabel ?? '') : label.label.name;

  Future<List<LocalContact>> _listContacts() async {
    final contacts = await FlutterContacts.getAll(
      properties: {
        ContactProperty.name,
        ContactProperty.phone,
        ContactProperty.email,
        ContactProperty.photoThumbnail,
        if (Platform.isAndroid) ...{ContactProperty.identifiers, ContactProperty.dataMimetypes},
      },
    );
    return contacts
        .where(_shouldIncludeContact)
        .map(
          (contact) => LocalContact(
            id: contact.id!,
            displayName: contact.displayName,
            firstName: contact.name?.first,
            lastName: contact.name?.last,
            thumbnail: contact.photo?.thumbnail,
            phones: contact.phones
                .map(
                  (phone) =>
                      LocalContactPhone(number: phone.number, label: _resolveLabelText(phone.label, PhoneLabel.custom)),
                )
                .toList(),
            emails: contact.emails
                .map(
                  (email) => LocalContactEmail(
                    address: email.address,
                    label: _resolveLabelText(email.label, EmailLabel.custom),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }
}
