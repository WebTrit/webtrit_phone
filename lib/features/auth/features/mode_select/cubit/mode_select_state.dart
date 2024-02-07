part of 'mode_select_cubit.dart';

enum ModeSelectStatus {
  processing,
  error,
  ok,
}

@freezed
class ModeSelectState with _$ModeSelectState {
  const ModeSelectState._();

  const factory ModeSelectState({
    required String url,
    required String defaultTenantId,
    ModeSelectStatus? status,
    required bool demo,
    @Default([]) List<SupportedLoginType> supportedLogin,
    Exception? error,
  }) = _ModeSelectStateState;

  bool get isProcessing => status == ModeSelectStatus.processing;
}
