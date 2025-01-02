import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/repositories/account/user_repository.dart';

part 'call_id_state.dart';

final _logger = Logger('CallIdCubit');

class CallIdCubit extends Cubit<CallIdState> {
  CallIdCubit(
    this._userRepository,
    this._appPreferences,
  ) : super(CallIdState.initializing()) {
    _init();
  }

  final UserRepository _userRepository;
  final AppPreferences _appPreferences;

  _init() async {
    try {
      final userInfo = await _userRepository.getInfo();

      final mainNumber = userInfo.numbers.main;
      final additionalNumbers = userInfo.numbers.additional;

      List<String> available = [
        mainNumber,
        if (additionalNumbers != null) ...additionalNumbers,
      ];

      bool enabled = _appPreferences.getCallIdEnabled();
      String? selected = _appPreferences.getCallIdSelected();

      // Reset selected number if it's not available anymore
      if (selected != null && !available.contains(selected)) {
        selected = null;
        _appPreferences.setCallIdSelected(null);
      }

      emit(CallIdState.common(enabled: enabled, available: available, selected: selected));
    } on Exception catch (e, s) {
      _logger.warning('Failed to init call id info', e, s);
      emit(CallIdState.initializing(error: e));
    }
  }

  refresh() {
    emit(CallIdState.initializing());
    _init();
  }

  void setEnabled(bool enabled) {
    final state = this.state;
    if (state is! CallIdStateCommon) return;

    _appPreferences.setCallIdEnabled(enabled);
    emit(state.copyWithEnabled(enabled));
  }

  void setSelected(String? selected) {
    final state = this.state;
    if (state is! CallIdStateCommon) return;

    _appPreferences.setCallIdSelected(selected);
    emit(state.copyWithSelected(selected));
  }
}
