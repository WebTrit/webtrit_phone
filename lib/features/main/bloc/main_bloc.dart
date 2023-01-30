import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'main_bloc.freezed.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required this.infoRepository,
  }) : super(const MainState()) {
    on<MainStarted>(_onStarted, transformer: restartable());
    on<MainCompatibilityVerified>(_onCompatibilityVerified, transformer: sequential());
  }

  final InfoRepository infoRepository;

  final _logger = Logger('$MainBloc');

  Timer? _repeatTimer;

  @override
  Future<void> close() async {
    _repeatTimer?.cancel();

    await super.close();
  }

  void _onStarted(MainStarted event, Emitter<MainState> emit) async {
    add(const MainCompatibilityVerified());
  }

  void _onCompatibilityVerified(MainCompatibilityVerified event, Emitter<MainState> emit) async {
    emit(state.copyWith(
      error: null,
    ));
    try {
      final actualCoreVersion = await infoRepository.getCoreVersion();
      CoreVersion.supported().verify(actualCoreVersion);
    } on CoreVersionUnsupportedException catch (e) {
      emit(state.copyWith(
        error: e,
      ));
    } catch (e, stackTrace) {
      const delay = kCompatibilityVerifyRepeatDelay;
      _logger.warning('_onCompatibilityVerified error - repeat in $delay', e, stackTrace);
      _repeatTimer?.cancel();
      _repeatTimer = Timer(delay, () {
        _logger.info('Timer callback - repeat after $delay');
        add(const MainCompatibilityVerified());
      });
    }
  }
}
