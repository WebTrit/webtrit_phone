import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';

import 'models/models.dart';
export 'models/models.dart';

class LocalContactsRepositoryPermissionException implements Exception {}

class LocalContactsRepository {
  LocalContactsRepository() {
    _controller = StreamController<List<LocalContact>>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  late StreamController<List<LocalContact>> _controller;
  late int _listenedCounter;

  List<LocalContact> _localContacts = [];

  Stream<List<LocalContact>> contacts() {
    return _controller.stream;
  }

  Future<void> load() async {
    _localContacts = await _listContacts();
    _controller.add(_localContacts);
  }

  void _onListenCallback() {
    if (_listenedCounter++ == 0) {
      FlutterContacts.addListener(_contactDatabaseChangesListener);
    }
  }

  void _onCancelCallback() {
    if (--_listenedCounter == 0) {
      FlutterContacts.removeListener(_contactDatabaseChangesListener);
    }
  }

  void _contactDatabaseChangesListener() async {
    await load();
  }

  Future<List<LocalContact>> _listContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      throw LocalContactsRepositoryPermissionException();
    }

    final contacts = await FlutterContacts.getContacts(withProperties: true, withThumbnail: true);
    return contacts
        .map((contact) => LocalContact(
              id: contact.id,
              displayName: contact.displayName,
              firstName: contact.name.first,
              lastName: contact.name.last,
              thumbnail: contact.thumbnail,
              phones: contact.phones
                  .map((phone) => LocalContactPhone(
                        number: phone.number,
                        label: phone.label == PhoneLabel.custom ? phone.customLabel : phone.label.name,
                      ))
                  .toList(),
            ))
        .toList();
  }
}
