import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/common/media_storage_service.dart';

import 'package:webtrit_phone/data/app_preferences.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit(this._appPreferences) : super(StorageState.initial(_appPreferences)) {
    _enumerateMediaCache();
  }

  final AppPreferences _appPreferences;

  Future<void> _enumerateMediaCache() async {
    final mediaCache = await MediaStorageService.enumerateMediaCache();
    final newState = state.copyWith(storageInfo: mediaCache);
    if (isClosed) return;
    emit(newState);
  }

  void setAutoClearDuration(Duration duration) {
    final newState = state.copyWith(autoClearDuration: duration);
    emit(newState);
    _appPreferences.setStorageAutoClearDuration(duration);
  }

  void setAutoDownloadEnabled(bool isEnabled) {
    final newState = state.copyWith(isAutoDownloadEnabled: isEnabled);
    emit(newState);
    _appPreferences.setStorageAutoDownload(isEnabled);
  }

  Future<void> clearCache() async {
    await MediaStorageService.clearMediaCache();
    final newState = state.copyWith(storageInfo: const {});
    emit(newState);
  }
}
