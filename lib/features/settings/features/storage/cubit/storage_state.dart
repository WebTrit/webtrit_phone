part of 'storage_cubit.dart';

class StorageState extends Equatable {
  const StorageState(
    this.autoClearDuration,
    this.isAutoDownloadOnWifiEnabled,
    this.isAutoDownloadOnCellularEnabled,
    this.storageInfo,
  );
  final Duration autoClearDuration;
  final bool isAutoDownloadOnWifiEnabled;
  final bool isAutoDownloadOnCellularEnabled;
  final Map<FileKind, double> storageInfo;

  factory StorageState.initial(AppPreferences prefs) {
    return StorageState(
      prefs.getStorageAutoClearDuration(),
      prefs.getAutoDownloadOnWifi(),
      prefs.getAutoDownloadOnCellular(),
      const {},
    );
  }

  StorageState copyWith({
    Duration? autoClearDuration,
    bool? isAutoDownloadOnWifiEnabled,
    bool? isAutoDownloadOnCellularEnabled,
    Map<FileKind, double>? storageInfo,
  }) {
    return StorageState(
      autoClearDuration ?? this.autoClearDuration,
      isAutoDownloadOnWifiEnabled ?? this.isAutoDownloadOnWifiEnabled,
      isAutoDownloadOnCellularEnabled ?? this.isAutoDownloadOnCellularEnabled,
      storageInfo ?? this.storageInfo,
    );
  }

  @override
  List<Object?> get props => [
        autoClearDuration,
        isAutoDownloadOnWifiEnabled,
        isAutoDownloadOnCellularEnabled,
        storageInfo,
      ];

  @override
  String toString() {
    return 'StorageState{autoClearDuration: $autoClearDuration, '
        'isAutoDownloadOnWifiEnabled: $isAutoDownloadOnWifiEnabled, '
        'isAutoDownloadOnCellularEnabled: $isAutoDownloadOnCellularEnabled, '
        'storageInfo: $storageInfo}';
  }
}
