import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/repositories/account/user_repository.dart';

part 'caller_id_state.dart';

class CallerIDSettingsCubit extends Cubit<CallerIDSettingsState> {
  CallerIDSettingsCubit(this._userRepository, this._appPreferences)
      : super(CallerIDSettingsState.initWithPrefs(_appPreferences)) {
    _userRepository.getInfo().then(_handleUserInfo);
    _userInfoSub = _userRepository.infoUpdates().listen(_handleUserInfo);
  }

  final UserRepository _userRepository;
  final AppPreferences _appPreferences;
  late final StreamSubscription _userInfoSub;

  void _handleUserInfo(UserInfo userInfo) {
    if (isClosed) return;
    emit(state.copyWithUserInfo(userInfo));
  }

  void setShow(bool value) {
    unawaited(_appPreferences.setShowCallerID(value));
    emit(state.copyWithShow(value));
  }

  void setSelected(String? selected) {
    unawaited(_appPreferences.setSelectedCallerID(selected));
    emit(state.copyWithSelected(selected));
  }

  @override
  Future<void> close() {
    _userInfoSub.cancel();
    return super.close();
  }
}
