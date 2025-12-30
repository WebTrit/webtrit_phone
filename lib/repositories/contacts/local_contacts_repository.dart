import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';

export 'local_contacts_repository_io.dart' if (dart.library.html) 'local_contacts_repository_html.dart';

abstract class ILocalContactsRepository {
  Future<bool> requestPermission();

  Stream<List<Contact>> contacts();

  Future<void> load();
}
