part of 'mode_select_cubit.dart';

enum ModeSelectStatus {
  processing,
  error,
  ok,
}

enum ModeSelectDirection {
  signUp,
  coreUrl,
}

@freezed
class ModeSelectState with _$ModeSelectState {
  const ModeSelectState._();

  const factory ModeSelectState({
    ModeSelectStatus? status,
    required bool demo,
    ModeSelectDirection? direction,
    Exception? error,
  }) = _ModeSelectStateState;

  bool get isProcessing => status == ModeSelectStatus.processing;
}
