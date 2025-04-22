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
  const factory EmbeddedState({
    @Default(EmbeddedStateStatus.initial) EmbeddedStateStatus status,
    @Default({}) Map<String, dynamic> payload,
  }) = _Initial;
}
