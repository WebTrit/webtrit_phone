import 'package:flutter/widgets.dart';

import 'package:equatable/equatable.dart';

import '../contact_source_type.dart';
import '../contacts_layout.dart';
import '../contacts_list_selection.dart';
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

  /// The kind segment of a stored [routePath] value - the decoder side of the
  /// encoding above, kept next to it so the two cannot drift apart. Subclasses
  /// may append their own segments (see [RecentsBottomMenuTab.routePath]), so
  /// only the first segment names the kind.
  static String flavorSegmentOf(String routePath) => routePath.split('/').first;

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
    required this.supportsCallHistory,
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  // Formerly `useCdrs`. Resolved from the adapter `callHistory` capability
  // (CoreSupport.supportsCallHistory); when true the recents tab uses remote CDRs.
  final bool supportsCallHistory;

  @override
  MainFlavor get flavor => MainFlavor.recents;

  @override
  String get routePath => '${super.routePath}${supportsCallHistory ? '/$cdrsSegment' : ''}';

  @override
  List<Object?> get props => [...super.props, supportsCallHistory];
}

final class VoicemailBottomMenuTab extends BottomMenuTab {
  const VoicemailBottomMenuTab({
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  });

  @override
  MainFlavor get flavor => MainFlavor.voicemail;
}

final class ContactsBottomMenuTab extends BottomMenuTab {
  static const unifiedSegment = 'unified';

  ContactsBottomMenuTab({
    required List<ContactSourceType> contactSourceTypes,
    required this.layout,
    required super.enabled,
    required super.initial,
    required super.titleL10n,
    required super.icon,
    super.data,
  }) : contactSourceTypes = List.unmodifiable(contactSourceTypes);

  final List<ContactSourceType> contactSourceTypes;

  /// How this tab arranges what it shows, and whatever that arrangement
  /// carries with it. The arrangements are separate screens, so the path
  /// below keeps them apart across a restart.
  final ContactsLayout layout;

  /// Whether a person can get at their favourites through this tab.
  bool get offersFavorites => layout.offersFavorites;

  /// What the unified arrangement offers to pick between: every configured
  /// address book, and - where this tab carries them - the favourites.
  ///
  /// Built here rather than in the screen so the answer is given once: the
  /// route that opens the section and the guard that repairs a route without
  /// arguments both need it, and the two disagreeing is a screen that offers
  /// favourites down one entry path and not the other.
  List<ContactsListSelection> get listSelections => [
    for (final sourceType in contactSourceTypes) ContactsSourceSelection(sourceType),
    if (offersFavorites) const ContactsFavoritesSelection(),
  ];

  @override
  MainFlavor get flavor => MainFlavor.contacts;

  @override
  String get routePath => switch (layout) {
    ContactsUnifiedLayout() => '${super.routePath}/$unifiedSegment',
    ContactsTabbedLayout() => super.routePath,
  };

  @override
  List<Object?> get props => [...super.props, contactSourceTypes, layout];
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
