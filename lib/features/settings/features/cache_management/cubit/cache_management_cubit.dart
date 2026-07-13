import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

part 'cache_management_state.dart';

part 'cache_management_cubit.freezed.dart';

final _logger = Logger('CacheManagementCubit');

/// Measures and clears the registered [CacheSection]s; the view only renders
/// [CacheManagementState].
class CacheManagementCubit extends Cubit<CacheManagementState> {
  CacheManagementCubit(AppCacheManager cacheManager)
    : _cacheManager = cacheManager,
      super(
        CacheManagementState(
          sections: [
            for (final section in cacheManager.sections)
              CacheSectionState(id: section.id, titleL10n: section.titleL10n, descriptionL10n: section.descriptionL10n),
          ],
        ),
      ) {
    for (final section in cacheManager.sections) {
      _measure(section);
    }
  }

  final AppCacheManager _cacheManager;

  Future<void> clearSection(String id) async {
    final section = _cacheManager.section(id);
    if (section == null) return;

    _emitSection(id, (it) => it.copyWith(clearing: true, usage: null));
    try {
      await section.clear();
    } catch (e, st) {
      _logger.warning('Failed to clear cache section $id', e, st);
    }
    _emitSection(id, (it) => it.copyWith(clearing: false));
    await _measure(section);
  }

  Future<void> _measure(CacheSection section) async {
    try {
      final usage = await section.usage();
      _emitSection(section.id, (it) => it.copyWith(usage: usage));
    } catch (e, st) {
      _logger.warning('Failed to measure cache section ${section.id}', e, st);
      _emitSection(section.id, (it) => it.copyWith(usage: const CacheUsage.bytes(0)));
    }
  }

  void _emitSection(String id, CacheSectionState Function(CacheSectionState) update) {
    if (isClosed) return;
    final section = state.sections.where((it) => it.id == id).firstOrNull;
    if (section == null) return;
    emit(state.copyWithSection(update(section)));
  }
}
