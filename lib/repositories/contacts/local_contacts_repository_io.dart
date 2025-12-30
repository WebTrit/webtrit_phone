import 'dart:async';
import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'local_contacts_repository.dart';

class LocalContactsRepository implements ILocalContactsRepository {
  LocalContactsRepository() {
    _controller = StreamController<List<Contact>>.broadcast(onListen: _onListenCallback, onCancel: _onCancelCallback);
    _listenedCounter = 0;
  }

  late StreamController<List<Contact>> _controller;
  late int _listenedCounter;

  @override
  Future<bool> requestPermission() async {
    if (await Permission.contacts.isPermanentlyDenied) {
      return false;
    } else {
      return await FlutterContacts.requestPermission();
    }
  }

  @override
  Stream<List<Contact>> contacts() {
    return _controller.stream;
  }

  @override
  Future<void> load() async {
    final contacts = await _listContacts();
    _controller.add(contacts);
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

  Future<List<Contact>> _listContacts() async {
    final contacts = await FlutterContacts.getContacts(withProperties: true, withAccounts: true, withThumbnail: true);
    return contacts.where((contact) {
      if (Platform.isAndroid) {
        for (final account in contact.accounts) {
          if (account.mimetypes.contains('vnd.android.cursor.item/phone_v2')) {
            return true;
          }
        }
        return false;
      } else {
        return true;
      }
    }).toList();
  }
}
