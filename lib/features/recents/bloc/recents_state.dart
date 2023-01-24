part of 'recents_bloc.dart';

@freezed
class RecentsState with _$RecentsState {
  const factory RecentsState({
    List<Recent>? recents,
  }) = _RecentsState;
}
