import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/models.dart';
import '../utils/utils.dart';

part 'orientations_bloc.freezed.dart';

part 'orientations_event.dart';

part 'orientations_state.dart';

/// Manages application screen orientation preferences, respecting the device's
/// system-wide auto-rotate setting.
class OrientationsBloc extends Bloc<OrientationsEvent, OrientationsState> {
  OrientationsBloc({required DeviceRotationUtil deviceRotationUtil})
    : _deviceRotationUtil = deviceRotationUtil,
      super(const OrientationsState()) {
    on<OrientationsChanged>(_onChanged, transformer: sequential());
    on<_SystemRotationChanged>(_onSystemRotationChanged, transformer: sequential());

    _rotationSubscription = _deviceRotationUtil.stream.listen((isEnabled) => add(_SystemRotationChanged(isEnabled)));
  }

  final DeviceRotationUtil _deviceRotationUtil;
  late final StreamSubscription<bool> _rotationSubscription;

  /// Handles explicit requests to change the app's preferred orientation mode.
  Future<void> _onChanged(OrientationsChanged event, Emitter<OrientationsState> emit) async {
    switch (event.orientation) {
      case PreferredOrientation.portrait:
        await setPortraitPreferredOrientations();
        break;
      case PreferredOrientation.auto:
        await _applyAutoOrientation();
        break;
    }

    emit(state.copyWith(lastOrientation: event.orientation));
  }

  /// Reacts to real-time system auto-rotate toggles (only when in [PreferredOrientation.auto]).
  Future<void> _onSystemRotationChanged(_SystemRotationChanged event, Emitter<OrientationsState> emit) async {
    if (state.lastOrientation != PreferredOrientation.auto) return;

    if (event.isSystemRotationEnabled) {
      await setAllPreferredOrientations();
    } else {
      await setPortraitPreferredOrientations();
    }
  }

  /// Checks the current system setting to decide if landscape should be allowed.
  Future<void> _applyAutoOrientation() async {
    final isSystemRotationEnabled = await _deviceRotationUtil.isEnabled;

    if (isSystemRotationEnabled) {
      await setAllPreferredOrientations();
    } else {
      await setPortraitPreferredOrientations();
    }
  }

  @override
  Future<void> close() {
    _rotationSubscription.cancel();
    return super.close();
  }
}
