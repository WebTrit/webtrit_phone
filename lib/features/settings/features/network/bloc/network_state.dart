part of 'network_cubit.dart';

@freezed
class NetworkState with _$NetworkState {
  const factory NetworkState({
    @Default([]) List<IncomingCallTypeModel> incomingCallTypeModels,
    @Default(false) bool smsFallbackEnabled,
  }) = _NetworkState;
}
