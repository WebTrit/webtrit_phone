part of 'embedded_cubit.dart';

enum EmbeddedStateStatus {
  initial,
  loading,
  ready,
  refreshing,
  error,
}

@freezed
class EmbeddedState with _$EmbeddedState {
  const EmbeddedState._();

  const factory EmbeddedState({
    @Default(EmbeddedStateStatus.initial) EmbeddedStateStatus status,
    @Default({}) Map<String, dynamic> payload,
    @Default(false) bool payloadReady,
    @Default(false) bool webViewReady,
  }) = _Initial;

  bool get isReadyToInjectedScript => payloadReady && webViewReady;
}
