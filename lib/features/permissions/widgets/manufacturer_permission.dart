import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

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
          title: context.l10n.permission_manufacturer_Text_heading,
          instruction: manufacturer.tips(context),
          onGoToAppSettings: onGoToAppSettings,
        );
    }
  }
}
