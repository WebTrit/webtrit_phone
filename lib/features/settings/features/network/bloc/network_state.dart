part of 'network_cubit.dart';

@freezed
class NetworkState with _$NetworkState {
  const factory NetworkState({
    @Default([]) List<IncomingCallTypeModel> incomingCallTypeModels,
    @Default(false) bool smsFallbackEnabled,
  }) = _NetworkState;
}

extension NetworkStateX on NetworkState {
  IncomingCallTypeModel? get selectedIncomingCallTypeModel =>
      incomingCallTypeModels.firstWhereOrNull((m) => m.selected);

  bool get isPersistentConnectionSelected => selectedIncomingCallTypeModel?.incomingCallType.isSocket ?? false;
}
