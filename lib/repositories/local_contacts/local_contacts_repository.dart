import 'dart:async';

import 'package:webtrit_phone/models/models.dart';

export 'local_contacts_repository_io.dart' if (dart.library.html) 'local_contacts_repository_html.dart';

class LocalContactsRepositoryPermissionException implements Exception {}

abstract class ILocalContactsRepository {
  Stream<List<LocalContact>> contacts();

  Future<void> load();
}
