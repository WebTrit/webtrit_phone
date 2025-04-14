import 'package:flutter/widgets.dart';

import '../contact_source_type.dart';
import '../main_flavor.dart';

import 'config_data.dart';

@immutable
class BottomMenuTab {
  final bool enabled;
  final bool initial;
  final MainFlavor flavor;
  final String titleL10n;
  final IconData icon;
  final ConfigData? data;

  const BottomMenuTab({
    required this.enabled,
    required this.initial,
    required this.flavor,
    required this.titleL10n,
    required this.icon,
    this.data,
  });

  String path() => flavor.name;
}

class ContactsBottomMenuTab extends BottomMenuTab {
  const ContactsBottomMenuTab({
    required this.contactSourceTypes,
    required super.enabled,
    required super.initial,
    required super.flavor,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  final List<ContactSourceType> contactSourceTypes;
}

class EmbeddedBottomMenuTab extends BottomMenuTab {
  const EmbeddedBottomMenuTab({
    required this.id,
    required super.enabled,
    required super.initial,
    required super.flavor,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  final int id;

  @override
  String path() => '${MainFlavor.embedded}/$id';
}

extension BottomMenuTabExtension on BottomMenuTab {
  ContactsBottomMenuTab? get toContacts {
    if (this is ContactsBottomMenuTab) {
      return this as ContactsBottomMenuTab?;
    } else {
      return null;
    }
  }

  EmbeddedBottomMenuTab? get toEmbedded {
    if (this is EmbeddedBottomMenuTab) {
      return this as EmbeddedBottomMenuTab?;
    } else {
      return null;
    }
  }
}
