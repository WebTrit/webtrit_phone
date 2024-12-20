import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/self_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('SelfConfigCubit');

/// A simple cubit that prefetches selfconfig and store data during the user's session.
class SelfConfigCubit extends Cubit<SelfConfigState> {
  SelfConfigCubit(this._selfConfigRepository, this._enabled) : super(SelfConfigState.initial()) {
    if (_enabled) fetchSelfConfig();
  }

  final SelfConfigRepository _selfConfigRepository;
  final bool _enabled;

  Future<void> fetchSelfConfig() async {
    try {
      emit(SelfConfigState.initial());
      final selfConfig = await _selfConfigRepository.getSelfConfig();
      emit(SelfConfigState.common(selfConfig));
    } catch (e, s) {
      _logger.severe('Error fetching selfconfig', e, s);
      emit(SelfConfigState.errored(e));

      // Auto retry after 10 seconds on unexpected error
      if (isClosed == false) {
        return Future.delayed(const Duration(seconds: 10), fetchSelfConfig);
      }
    }
  }
}

sealed class SelfConfigState {
  const SelfConfigState();

  factory SelfConfigState.initial() => SelfConfigStateInitial();
  factory SelfConfigState.common(SelfConfig selfConfig) => SelfConfigStateCommon(selfConfig);
  factory SelfConfigState.errored(Object error) => SelfConfigStateErrored(error);
}

final class SelfConfigStateInitial extends SelfConfigState {}

final class SelfConfigStateCommon extends SelfConfigState with EquatableMixin {
  SelfConfigStateCommon(this.selfConfig);
  final SelfConfig selfConfig;

  @override
  List<Object?> get props => [selfConfig];

  @override
  toString() => 'SelfConfigState(userInfo: $selfConfig)';
}

final class SelfConfigStateErrored extends SelfConfigState with EquatableMixin {
  SelfConfigStateErrored(this.error);

  final Object error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SelfConfigStateError { error: $error }';
}
