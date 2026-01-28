import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../embedded/embedded.dart';
import '../settings_flavor.dart';

class SettingsSection extends Equatable {
  const SettingsSection({required this.titleL10n, required this.items});

  final String titleL10n;
  final List<SettingItem> items;

  @override
  List<Object?> get props => [titleL10n, items];
}

class SettingItem extends Equatable {
  const SettingItem({required this.titleL10n, required this.icon, required this.flavor, this.data, this.iconColor});

  final String titleL10n;
  final IconData icon;
  final Color? iconColor;
  final SettingsFlavor flavor;
  final EmbeddedData? data;

  @override
  List<Object?> get props => [titleL10n, icon, iconColor, flavor, data];
}
