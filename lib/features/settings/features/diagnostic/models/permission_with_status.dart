import 'package:permission_handler/permission_handler.dart';

class PermissionWithStatus {
  final Permission permission;
  final PermissionStatus status;

  PermissionWithStatus(this.permission, this.status);
}
