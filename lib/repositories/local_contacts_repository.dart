import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:webtrit_phone/models/models.dart';

class LocalContactsRepository {
  LocalContactsRepository() {
    _controller = StreamController<List<LocalContact>>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  StreamController _controller;
  int _listenedCounter;

  List<LocalContact> _localContacts;

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
    final contacts = await FlutterContacts.getContacts(withThumbnail: true);
    return contacts
        .map((contact) => LocalContact(
              displayName: contact.displayName,
              thumbnail: contact.thumbnail,
            ))
        .toList();
  }
}
