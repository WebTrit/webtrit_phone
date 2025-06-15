import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/lines_state.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'call_routing_state.dart';

class CallRoutingCubit extends Cubit<CallRoutingState?> {
  CallRoutingCubit(
    this._userRepository,
    this._linesStateRepository,
    this._appPreferences,
  ) : super(null) {
    _infoSub = _userRepository
        .getInfoAndListen()
        .combineLatest(_linesStateRepository.getStateAndListen(), _combineInfo)
        .listen(emit);
  }

  final LinesStateRepository _linesStateRepository;
  final UserRepository _userRepository;
  final AppPreferences _appPreferences;
  late final StreamSubscription _infoSub;

  CallRoutingState _combineInfo(UserInfo userInfo, LinesState linesState) {
    final mainNumber = userInfo.numbers.main;
    final additionalNumbers = userInfo.numbers.additional?.nonNulls.toList() ?? [];
    final mainLinesState = linesState.mainLines;
    final guestLineState = linesState.guestLine;

    final callerIdSettings = _appPreferences.getCallerIdSettings();
    final matchers = callerIdSettings.matchers;
    final defaultNumber = callerIdSettings.defaultNumber;

    // Reset cli settings if additional number removed from user
    if (defaultNumber != null && !additionalNumbers.contains(defaultNumber)) {
      _appPreferences.setCallerIdSettings(callerIdSettings.copyWithDefaultNumber(null));
      additionalNumbers.add(defaultNumber);
    }
    for (final matcher in matchers) {
      if (!additionalNumbers.contains(matcher.number)) {
        final filteredMatchers = matchers.where((m) => m.number != matcher.number).toList();
        _appPreferences.setCallerIdSettings(callerIdSettings.copyWithMatchers(filteredMatchers));
      }
    }

    return CallRoutingState._(mainNumber, additionalNumbers, mainLinesState, guestLineState);
  }

  /// Returns the number to use for call `from` parameter
  /// based on the caller ID settings and destination number.
  ///
  /// Returns `null` if no number specified for call.
  String? getFromNumber(String destination) {
    final callerIdSettings = _appPreferences.getCallerIdSettings();
    final matchers = callerIdSettings.matchers;
    final defaultNumber = callerIdSettings.defaultNumber;

    final matched = matchers.where((m) => m.match(destination)).toList();
    if (matched.isNotEmpty) {
      // Sort by match index to find the longest match
      // e.g +126812345678 will match +1268 against +1
      matched.sort((a, b) => b.matchIndex.compareTo(a.matchIndex));
      return matched.first.number;
    }

    return defaultNumber;
  }

  @override
  Future<void> close() {
    _infoSub.cancel();
    return super.close();
  }
}
