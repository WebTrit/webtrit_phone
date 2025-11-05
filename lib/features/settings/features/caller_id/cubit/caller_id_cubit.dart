import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/caller_id_settings.dart';
import 'package:webtrit_phone/repositories/account/user_repository.dart';

class CallerIdSettingsState extends Equatable {
  const CallerIdSettingsState({required this.settings, required this.mainNumber, required this.additionalNumbers});

  final CallerIdSettings settings;
  final String mainNumber;
  final List<String> additionalNumbers;

  @override
  List<Object> get props => [settings, mainNumber, additionalNumbers];

  @override
  String toString() {
    return 'CallerIdSettingsState(settings: $settings, mainNumber: $mainNumber, additionalNumbers: $additionalNumbers)';
  }

  CallerIdSettingsState copyWith({CallerIdSettings? settings, String? mainNumber, List<String>? additionalNumbers}) {
    return CallerIdSettingsState(
      settings: settings ?? this.settings,
      mainNumber: mainNumber ?? this.mainNumber,
      additionalNumbers: additionalNumbers ?? this.additionalNumbers,
    );
  }
}

class CallerIdSettingsCubit extends Cubit<CallerIdSettingsState?> {
  CallerIdSettingsCubit(this._appPreferences, this._userRepository) : super(null);

  final UserRepository _userRepository;
  final AppPreferences _appPreferences;

  void init() async {
    final settings = _appPreferences.getCallerIdSettings();
    final userInfo = (await _userRepository.getInfo())!;
    final mainNumber = userInfo.numbers.main;
    final additionalNumbers = userInfo.numbers.additional?.nonNulls.toList() ?? <String>[];

    emit(CallerIdSettingsState(settings: settings, mainNumber: mainNumber, additionalNumbers: additionalNumbers));
  }

  void setDefaultNumber(String? number) {
    final state = this.state;
    if (state == null) return;

    final settings = state.settings.copyWithDefaultNumber(number);
    _appPreferences.setCallerIdSettings(settings);
    emit(state.copyWith(settings: settings));
  }

  void addPrefixMatcher(String prefix, String number) {
    final state = this.state;
    if (state == null) return;

    final matcher = PrefixMatcher(prefix, number);
    final settings = state.settings.copyWithMatchers([...state.settings.matchers, matcher]);
    _appPreferences.setCallerIdSettings(settings);
    emit(state.copyWith(settings: settings));
  }

  void removePrefixMatcher(String prefix) {
    final state = this.state;
    if (state == null) return;

    final matchers = state.settings.matchers.whereNot((m) => m is PrefixMatcher && m.prefix == prefix).toList();
    final settings = state.settings.copyWithMatchers(matchers);
    _appPreferences.setCallerIdSettings(settings);
    emit(state.copyWith(settings: settings));
  }
}
