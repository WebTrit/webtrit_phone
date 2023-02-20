import 'dart:async';

import 'package:webtrit_phone/models/models.dart';

import 'local_contacts_repository.dart';

class LocalContactsRepository implements ILocalContactsRepository {
  LocalContactsRepository();

  @override
  Future<bool> requestPermission() {
    return Future.value(true);
  }

  @override
  Stream<List<LocalContact>> contacts() {
    return const Stream.empty();
  }

  @override
  Future<void> load() async {
    return;
  }
}
