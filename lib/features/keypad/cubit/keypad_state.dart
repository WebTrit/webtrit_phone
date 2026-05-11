part of 'keypad_cubit.dart';

@freezed
class KeypadState with _$KeypadState {
  KeypadState({this.contact, this.value});

  @override
  final Contact? contact;

  @override
  final String? value;

  late final noValue = value?.isEmpty ?? true;
}
