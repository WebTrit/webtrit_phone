import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../call/call.dart';

part 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit({
    required this.callBloc,
  }) : super(KeypadState(transfer: callBloc.state.hasTransfer)) {
    callBlocStreamSubscription = callBloc.stream.listen((state) {
      if (state.hasTransfer) {
        emit(const KeypadState(transfer: true));
      } else {
        emit(const KeypadState(transfer: false));
      }
    });
  }

  final CallBloc callBloc;
  StreamSubscription? callBlocStreamSubscription;

  @override
  Future<void> close() async {
    await callBlocStreamSubscription?.cancel();

    await super.close();
  }

  void call(String number) {
    if (state.transfer) {
      callBloc.add(CallControlEvent.unattendedTransferred(number));
    } else {
      callBloc.add(CallControlEvent.started(
        number: number,
        video: state.video,
      ));
    }
  }

  void callTypeSwitch() {
    emit(KeypadState(video: !state.video));
  }
}
