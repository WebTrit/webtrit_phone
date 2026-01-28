import 'package:flutter/widgets.dart';

import 'package:equatable/equatable.dart';

import '../contact_source_type.dart';
import '../embedded/embedded.dart';
import '../main_flavor.dart';

sealed class BottomMenuTab extends Equatable {
  const BottomMenuTab({
    required this.enabled,
    required this.initial,
    required this.titleL10n,
    required this.icon,
    this.data,
  });

  final bool enabled;
  final bool initial;
  final String titleL10n;
  final IconData icon;
  final EmbeddedData? data;

  MainFlavor get flavor;

  ({String flavor, String? embeddedId}) get pathParts => (flavor: flavor.name, embeddedId: null);

  String get routePath => switch (pathParts) {
    (flavor: final f, embeddedId: null) => f,
    (flavor: final f, embeddedId: final id) => '$f/$id',
  };

  @override
  List<Object?> get props => [enabled, initial, titleL10n, icon, data, flavor];
}

final class FavoritesBottomMenuTab extends BottomMenuTab {
  const FavoritesBottomMenuTab({
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  @override
  MainFlavor get flavor => MainFlavor.favorites;
}

final class KeypadBottomMenuTab extends BottomMenuTab {
  const KeypadBottomMenuTab({
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  @override
  MainFlavor get flavor => MainFlavor.keypad;
}

final class MessagingBottomMenuTab extends BottomMenuTab {
  const MessagingBottomMenuTab({
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  @override
  MainFlavor get flavor => MainFlavor.messaging;
}

final class RecentsBottomMenuTab extends BottomMenuTab {
  static const cdrsSegment = 'cdrs';

  const RecentsBottomMenuTab({
    required this.useCdrs,
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  final bool useCdrs;

  @override
  MainFlavor get flavor => MainFlavor.recents;

  @override
  String get routePath => '${super.routePath}${useCdrs ? '/$cdrsSegment' : ''}';

  @override
  List<Object?> get props => [...super.props, useCdrs];
}

final class ContactsBottomMenuTab extends BottomMenuTab {
  const ContactsBottomMenuTab({
    required this.contactSourceTypes,
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  final List<ContactSourceType> contactSourceTypes;

  @override
  MainFlavor get flavor => MainFlavor.contacts;

  @override
  List<Object?> get props => [...super.props, contactSourceTypes];
}

final class EmbeddedBottomMenuTab extends BottomMenuTab {
  const EmbeddedBottomMenuTab({
    required this.id,
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  final String id;

  @override
  MainFlavor get flavor => MainFlavor.embedded;

  @override
  ({String flavor, String? embeddedId}) get pathParts => (flavor: MainFlavor.embedded.name, embeddedId: id);

  @override
  List<Object?> get props => [...super.props, id];
}
