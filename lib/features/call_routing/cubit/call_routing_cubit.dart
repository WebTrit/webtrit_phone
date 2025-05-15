import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

// TODO: rename to call lines cubit

class CallRoutingState extends Equatable {
  CallRoutingState._(
    this.mainNumber,
    this.additionalNumbers,
    this.mainLinesState,
    this.guestLineState,
    this.useAdditionalNumber,
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

  /// The number from which the user prefer make calls using guest line.
  final String? useAdditionalNumber;

  /// Return true if the user supports make calls using guest line with additional numbers.
  late final callAsSupports = guestLineState != null && additionalNumbers.isNotEmpty;

  /// Returns true if the user can make calls using guest line with additional numbers.
  late final canCallAs = guestLineState == LineState.idle && additionalNumbers.isNotEmpty;

  /// Returns boolean indicating if the user can make calls using main number.
  late final canCallWithMainNumber = mainLinesState.any((lineState) => lineState == LineState.idle);

  @override
  List<Object?> get props => [mainNumber, additionalNumbers, mainLinesState, guestLineState, useAdditionalNumber];

  @override
  String toString() {
    return 'CallRoutingState{mainNumber: $mainNumber, additionalNumbers: $additionalNumbers, mainLinesState: $mainLinesState, guestLineState: $guestLineState, useAdditionalNumber: $useAdditionalNumber}';
  }

  CallRoutingState copyWithUseAdditionalNumber(String? number) {
    return CallRoutingState._(mainNumber, additionalNumbers, mainLinesState, guestLineState, number);
  }
}

class CallRoutingCubit extends Cubit<CallRoutingState?> {
  CallRoutingCubit(this._userRepository, this._linesStateRepository) : super(null) {
    _infoSub = _userRepository
        .getInfoAndListen()
        .combineLatest(_linesStateRepository.getStateAndListen(), _combineInfo)
        .listen(emit);
  }

  final LinesStateRepository _linesStateRepository;
  final UserRepository _userRepository;
  late final StreamSubscription _infoSub;

  CallRoutingState _combineInfo(UserInfo userInfo, LinesState linesState) {
    final mainNumber = userInfo.numbers.main;
    final additionalNumbers = userInfo.numbers.additional?.nonNulls.toList() ?? [];
    final mainLinesState = linesState.mainLines;
    final guestLineState = linesState.guestLine;

    // Remove selected number if its not available after update or keep it if its available
    final oldUseNumber = state?.useAdditionalNumber;
    final useAdditionalNumber = additionalNumbers.contains(oldUseNumber) ? oldUseNumber : null;

    return CallRoutingState._(mainNumber, additionalNumbers, mainLinesState, guestLineState, useAdditionalNumber);
  }

  void setAdditionalNumberToUse(String? number) {
    emit(state!.copyWithUseAdditionalNumber(number));
  }

  @override
  Future<void> close() {
    _infoSub.cancel();
    return super.close();
  }
}
