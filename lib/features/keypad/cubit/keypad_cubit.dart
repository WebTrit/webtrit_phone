import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit() : super(const KeypadState());
}
