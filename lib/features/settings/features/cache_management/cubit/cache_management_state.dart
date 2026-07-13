part of 'cache_management_cubit.dart';

/// Snapshot of one [CacheSection] for rendering: its static descriptors plus
/// the last measured usage (null while measuring), a measure-failure flag and
/// a clear-in-progress flag.
@freezed
class CacheSectionState with _$CacheSectionState {
  const CacheSectionState({
    required this.id,
    required this.titleL10n,
    required this.descriptionL10n,
    this.usage,
    this.measureFailed = false,
    this.clearing = false,
  });

  @override
  final String id;

  @override
  final String titleL10n;

  @override
  final String descriptionL10n;

  @override
  final CacheUsage? usage;

  @override
  final bool measureFailed;

  @override
  final bool clearing;
}

@freezed
class CacheManagementState with _$CacheManagementState {
  const CacheManagementState({this.sections = const []});

  @override
  final List<CacheSectionState> sections;

  CacheManagementState copyWithSection(CacheSectionState section) {
    return CacheManagementState(
      sections: [
        for (final it in sections)
          if (it.id == section.id) section else it,
      ],
    );
  }
}
