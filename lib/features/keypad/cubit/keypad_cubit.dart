import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/blocs/blocs.dart';

part 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit({
    required this.callBloc,
  }) : super(KeypadState());

  final CallBloc callBloc;

  final _logger = Logger('$KeypadCubit');

  void call(String number) {
    _logger.info('call to [$number]');
    callBloc.add(CallOutgoingStarted(number: number, video: false));
  }
}
