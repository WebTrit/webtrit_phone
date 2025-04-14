import 'package:flutter/widgets.dart';

import '../settings_flavor.dart';

import 'embedded_data.dart';

class SettingsSection {
  final String titleL10n;
  final List<SettingItem> items;

  SettingsSection({
    required this.titleL10n,
    required this.items,
  });
}

class SettingItem {
  final String titleL10n;
  final IconData icon;
  final SettingsFlavor flavor;
  final EmbeddedData? data;

  SettingItem({
    required this.titleL10n,
    required this.icon,
    required this.flavor,
    this.data,
  });
}
