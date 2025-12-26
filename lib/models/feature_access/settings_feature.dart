import 'package:flutter/widgets.dart';

import '../settings_flavor.dart';
import '../embedded/embedded.dart';

class SettingsSection {
  SettingsSection({required this.titleL10n, required this.items});

  final String titleL10n;
  final List<SettingItem> items;
}

class SettingItem {
  SettingItem({required this.titleL10n, required this.icon, required this.flavor, this.data, this.iconColor});

  final String titleL10n;
  final IconData icon;
  final Color? iconColor;
  final SettingsFlavor flavor;
  final EmbeddedData? data;
}
