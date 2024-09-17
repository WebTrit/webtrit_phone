import 'package:flutter/widgets.dart';

class AccountSection {
  final String titleL10n;
  final List<AccountItem> items;

  AccountSection({
    required this.titleL10n,
    required this.items,
  });
}

class AccountItem {
  final String titleL10n;
  final IconData icon;
  final String type;
  final AccountItemData? data;

  AccountItem({
    required this.titleL10n,
    required this.icon,
    required this.type,
    required this.data,
  });
}

class AccountItemData {
  final String url;

  AccountItemData({
    required this.url,
  });
}
