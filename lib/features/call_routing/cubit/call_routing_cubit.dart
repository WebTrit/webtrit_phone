import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:webtrit_phone/data/app_preferences.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

class CallRoutingState extends Equatable {
  CallRoutingState._(
    this.mainNumber,
    this.additionalNumbers,
    this.mainLinesState,
    this.guestLineState,
  );

  /// The main number of the user. From which the user makees calls regularly.
  final String mainNumber;

  /// The additional numbers of the user. From which the user can make calls.
  final List<String> additionalNumbers;

  /// The states of the main sip registration lines.
  /// From which the can make calls using main number.
  final List<LineState> mainLinesState;

  /// The state of the guest line.
  /// From which the user can make calls using additional numbers.
  /// `null` means that guest line is not supported.
  final LineState? guestLineState;

  /// Returns true if the user can make calls using any of the numbers.
  late final allNumbers = <String>[mainNumber, ...additionalNumbers];

  @override
  List<Object?> get props => [mainNumber, additionalNumbers, mainLinesState, guestLineState];

  @override
  String toString() {
    return 'CallRoutingState{mainNumber: $mainNumber, additionalNumbers: $additionalNumbers, mainLinesState: $mainLinesState, guestLineState: $guestLineState}';
  }
}

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
