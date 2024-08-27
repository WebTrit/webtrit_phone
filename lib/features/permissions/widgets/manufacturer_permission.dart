import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';

import 'permission_tips.dart';

class ManufacturerPermission extends StatelessWidget {
  const ManufacturerPermission({
    super.key,
    required this.manufacturer,
    required this.onGoToAppSettings,
  });

  final Manufacturer manufacturer;
  final VoidCallback onGoToAppSettings;

  @override
  Widget build(BuildContext context) {
    switch (manufacturer) {
      case Manufacturer.xiaomi:
        return PermissionTips(
          instruction: manufacturer.tips(context),
          onGoToAppSettings: onGoToAppSettings,
        );
    }
  }
}
