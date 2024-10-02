import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension ManufacturerTips on Manufacturer {
  List<String> tips(BuildContext context) {
    switch (this) {
      case Manufacturer.xiaomi:
        return [
          context.l10n.permission_manufacturer_Text_xiaomi_tip1,
          context.l10n.permission_manufacturer_Text_xiaomi_tip2,
        ];
    }
  }
}
