import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/app_permissions.dart';

part 'microphone_status_bloc.freezed.dart';

part 'microphone_status_event.dart';

part 'microphone_status_state.dart';

class MicrophoneStatusBloc extends Bloc<MicrophoneStatusEvent, MicrophoneStatusState> {
  MicrophoneStatusBloc({required AppPermissions appPermissions}) : super(MicrophoneStatusState()) {
    _appPermissions = appPermissions;

    on<MicrophoneStatusStarted>(_onMicrophoneStatusStarted);
  }

  late final AppPermissions _appPermissions;

  Future<void> _onMicrophoneStatusStarted(MicrophoneStatusStarted event, Emitter<MicrophoneStatusState> emit) async {
    await emit.forEach<bool>(
      getPermissionStream,
      onData: (isGranted) => state.copyWith(microphonePermissionGranted: isGranted),
    );
  }

  Stream<bool> get getPermissionStream => Stream.periodic(
    const Duration(seconds: 5),
    (i) => _appPermissions.isPermissionGranted(Permission.microphone),
  ).asyncMap((status) => status);
}
