part of 'keypad_cubit.dart';

@freezed
class KeypadState with _$KeypadState {
  const KeypadState({this.contact});

  @override
  final Contact? contact;
}
