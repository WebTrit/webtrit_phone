import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/blocs/blocs.dart';

part 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit({
    required this.callBloc,
  }) : super(const KeypadState());

  final CallBloc callBloc;

  final _logger = Logger('$KeypadCubit');

  void call(String number) {
    _logger.info('${state.video ? 'video' : 'audio'} call to [$number]');
    callBloc.add(CallOutgoingStarted(number: number, video: state.video));
  }

  void callTypeSiwtch() {
    emit(KeypadState(video: !state.video));
  }
}
