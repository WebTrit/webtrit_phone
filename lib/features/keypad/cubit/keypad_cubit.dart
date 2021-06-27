import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit() : super(KeypadState());

  final _logger = Logger('$KeypadCubit');

  void call(String number) {
    _logger.info('call to [$number]');
  }
}
