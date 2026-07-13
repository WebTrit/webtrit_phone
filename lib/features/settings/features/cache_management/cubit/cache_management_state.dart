import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/models.dart';

/// Snapshot of one [CacheSection] for rendering: its static descriptors plus
/// the last measured usage (null while measuring) and a clear-in-progress flag.
class CacheSectionState extends Equatable {
  const CacheSectionState({
    required this.id,
    required this.titleL10n,
    required this.descriptionL10n,
    this.usage,
    this.clearing = false,
  });

  final String id;
  final String titleL10n;
  final String descriptionL10n;
  final CacheUsage? usage;
  final bool clearing;

  CacheSectionState copyWith({CacheUsage? usage, bool? clearing, bool remeasuring = false}) {
    return CacheSectionState(
      id: id,
      titleL10n: titleL10n,
      descriptionL10n: descriptionL10n,
      usage: remeasuring ? null : (usage ?? this.usage),
      clearing: clearing ?? this.clearing,
    );
  }

  @override
  List<Object?> get props => [id, titleL10n, descriptionL10n, usage, clearing];
}

class CacheManagementState extends Equatable {
  const CacheManagementState({this.sections = const []});

  final List<CacheSectionState> sections;

  CacheManagementState copyWithSection(CacheSectionState section) {
    return CacheManagementState(
      sections: [
        for (final it in sections)
          if (it.id == section.id) section else it,
      ],
    );
  }

  @override
  List<Object?> get props => [sections];
}
