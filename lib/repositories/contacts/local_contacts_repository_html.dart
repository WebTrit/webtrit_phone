import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';

import 'local_contacts_repository.dart';

class LocalContactsRepository implements ILocalContactsRepository {
  LocalContactsRepository();

  @override
  Future<bool> requestPermission() {
    return Future.value(true);
  }

  @override
  Stream<List<Contact>> contacts() {
    return const Stream.empty();
  }

  @override
  Future<void> load() async {
    return;
  }
}
