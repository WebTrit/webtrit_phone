import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import '../models/models.dart';

part 'network_state.dart';

part 'network_cubit.freezed.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(
    this._appPreferences,
    this._callkeepBackgroundService,
  ) : super(const NetworkState()) {
    _initializeActiveIncomingType();
  }

  final AppPreferences _appPreferences;
  final CallkeepBackgroundService _callkeepBackgroundService;

  Future<void> _initializeActiveIncomingType() async {
    final currentType = _appPreferences.getIncomingCallType();
    final models = IncomingCallType.values.map((type) => IncomingCallTypeModel(type, type == currentType)).toList();

    emit(state.copyWith(incomingCallTypeModels: models));
  }

  Future<void> selectIncomingCallType(IncomingCallTypeModel selectedTypeModel) async {
    _appPreferences.setIncomingCallType(selectedTypeModel.incomingCallType);

    switch (selectedTypeModel.incomingCallType) {
      case IncomingCallType.pushNotification:
        await _callkeepBackgroundService.setUp(
          type: CallkeepIncomingType.pushNotification,
          autoStartOnBoot: false,
          autoRestartOnTerminate: false,
        );
        await _callkeepBackgroundService.stopService();
        break;
      case IncomingCallType.socket:
        await _callkeepBackgroundService.setUp(
          type: CallkeepIncomingType.socket,
          autoStartOnBoot: true,
          autoRestartOnTerminate: true,
        );
        await _callkeepBackgroundService.startService();
        break;
    }

    await _initializeActiveIncomingType();
  }
}
