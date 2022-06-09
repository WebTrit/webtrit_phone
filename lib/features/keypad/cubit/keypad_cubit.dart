import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../call/call.dart';

part 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit({
    required this.callBloc,
  }) : super(const KeypadState());

  final CallBloc callBloc;

  void call(String number) {
    callBloc.add(CallControlEvent.started(
      number: number,
      video: state.video,
    ));
  }

  void callTypeSiwtch() {
    emit(KeypadState(video: !state.video));
  }
}
