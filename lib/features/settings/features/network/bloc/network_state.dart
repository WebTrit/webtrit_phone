part of 'network_cubit.dart';

@freezed
class NetworkState with _$NetworkState {
  const NetworkState._();

  const factory NetworkState({
    @Default([]) List<IncomingCallTypeModel> incomingCallTypeModels,
    @Default([]) List<IncomingCallType> incomingCallTypesRemainder,
    @Default(false) bool smsFallbackEnabled,
  }) = _NetworkState;

  IncomingCallTypeModel? get selectedIncomingCallTypeModel =>
      incomingCallTypeModels.firstWhereOrNull((m) => m.selected);

  IncomingCallType get incomingCallType =>
      selectedIncomingCallTypeModel?.incomingCallType ?? IncomingCallType.pushNotification;
}
