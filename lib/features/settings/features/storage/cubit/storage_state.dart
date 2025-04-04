part of 'storage_cubit.dart';

class StorageState extends Equatable {
  const StorageState(
    this.autoClearDuration,
    this.isAutoDownloadEnabled,
    this.storageInfo,
  );
  final Duration autoClearDuration;
  final bool isAutoDownloadEnabled;
  final Map<FileKind, double> storageInfo;

  factory StorageState.initial(AppPreferences prefs) {
    return StorageState(prefs.getStorageAutoClearDuration(), prefs.getStorageAutoDownload(), const {});
  }

  StorageState copyWith({
    Duration? autoClearDuration,
    bool? isAutoDownloadEnabled,
    Map<FileKind, double>? storageInfo,
  }) {
    return StorageState(
      autoClearDuration ?? this.autoClearDuration,
      isAutoDownloadEnabled ?? this.isAutoDownloadEnabled,
      storageInfo ?? this.storageInfo,
    );
  }

  @override
  List<Object?> get props => [autoClearDuration, isAutoDownloadEnabled, storageInfo];

  @override
  String toString() {
    return 'StorageState{autoClearDuration: $autoClearDuration, isAutoDownloadEnabled: $isAutoDownloadEnabled, storageInfo: $storageInfo}';
  }
}
