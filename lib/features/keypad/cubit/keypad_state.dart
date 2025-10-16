part of 'keypad_cubit.dart';

@freezed
abstract class KeypadState with _$KeypadState {
  const factory KeypadState({
    Contact? contact,
  }) = _KeypadState;
}
