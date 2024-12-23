import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('RegisterStatusCubit');

class RegisterStatusCubit extends Cubit<RegisterStatus> {
  RegisterStatusCubit(
    this.appRepository,
    this.appPreferences, {
    this.handleError,
  }) : super(appPreferences.getRegisterStatus()) {
    fetchStatus();
  }

  final AppRepository appRepository;
  final AppPreferences appPreferences;
  final Function(Object error, StackTrace stackTrace)? handleError;

  Future<void> fetchStatus() async {
    try {
      final status = await appRepository.getRegisterStatus();
      appPreferences.setRegisterStatus(status);
      emit(status);
    } catch (e, s) {
      _logger.warning('Failed to get register status', e, s);
      handleError?.call(e, s);
    }
  }

  Future<void> setStatus(bool value) async {
    try {
      await appRepository.setRegisterStatus(value);
      await appPreferences.setRegisterStatus(value);
      emit(value);
    } catch (e, stackTrace) {
      _logger.warning('_onRegisterStatusChanged', e, stackTrace);
      handleError?.call(e, stackTrace);
    }
  }
}

typedef RegisterStatus = bool;
