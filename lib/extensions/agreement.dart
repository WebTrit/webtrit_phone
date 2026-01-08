import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/models/models.dart';

extension AgreementExtension on AgreementStatus {
  List<Permission> get excludedPermissions => [if (!isAccepted) Permission.contacts];
}
