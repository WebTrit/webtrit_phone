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
    this.appPreferences,
    this.callkeepBackgroundService,
  ) : super(const NetworkState()) {
    _getActiveIncomingType();
  }

  final AppPreferences appPreferences;
  final CallkeepBackgroundService callkeepBackgroundService;

  void _getActiveIncomingType() async {
    final type = appPreferences.getIncomingCallType();

    emit(NetworkState(
      incomingCallTypeModels: IncomingCallType.values.map((it) => IncomingCallTypeModel(it, it == type)).toList(),
    ));
  }

  void selectIncomingCallType(IncomingCallTypeModel incomingCallTypeModel) async {
    appPreferences.setIncomingCallType(incomingCallTypeModel.incomingCallType);

    switch (incomingCallTypeModel.incomingCallType) {
      case IncomingCallType.pushNotification:
        await callkeepBackgroundService.setUp(
          type: CallkeepIncomingType.pushNotification,
          autoStartOnBoot: false,
          autoRestartOnTerminate: false,
        );
        await callkeepBackgroundService.stopService();
        break;
      case IncomingCallType.socket:
        await callkeepBackgroundService.setUp(
          type: CallkeepIncomingType.socket,
          autoStartOnBoot: true,
          autoRestartOnTerminate: true,
        );
        await callkeepBackgroundService.startService();
        break;
    }

    _getActiveIncomingType();
  }
}
