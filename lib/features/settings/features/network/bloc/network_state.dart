part of 'network_cubit.dart';

@freezed
class NetworkState with _$NetworkState {
  // const NetworkState._();

  const NetworkState({
    this.incomingCallTypeModels = const [],
    this.incomingCallTypesRemainder = const [],
    this.smsFallbackEnabled = false,
  });

  @override
  final List<IncomingCallTypeModel> incomingCallTypeModels;
  @override
  final List<IncomingCallType> incomingCallTypesRemainder;
  @override
  final bool smsFallbackEnabled;

  IncomingCallTypeModel? get selectedIncomingCallTypeModel =>
      incomingCallTypeModels.firstWhereOrNull((m) => m.selected);

  IncomingCallType get incomingCallType =>
      selectedIncomingCallTypeModel?.incomingCallType ?? IncomingCallType.pushNotification;

  bool get isSelectedTypeInRemainder => incomingCallTypesRemainder.contains(incomingCallType);
}
