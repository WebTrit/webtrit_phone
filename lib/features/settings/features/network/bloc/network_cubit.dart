import 'package:bloc/bloc.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import '../models/models.dart';

part 'network_state.dart';

part 'network_cubit.freezed.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(
    this._callTriggerConfig,
    this._appPreferences,
    this._callkeepBackgroundService,
  ) : super(NetworkState(smsFallbackEnabled: _callTriggerConfig.smsFallback.enabled)) {
    _initializeActiveIncomingType();
  }

  final CallTriggerConfig _callTriggerConfig;
  final AppPreferences _appPreferences;
  final BackgroundSignalingBootstrapService _callkeepBackgroundService;

  bool get smsFallbackAvailable => _callTriggerConfig.smsFallback.available;

  void _initializeActiveIncomingType() {
    final currentType = _appPreferences.getIncomingCallType();
    final models = IncomingCallType.values.map((type) => IncomingCallTypeModel(type, type == currentType)).toList();

    emit(state.copyWith(incomingCallTypeModels: models));
  }

  Future<void> selectIncomingCallType(IncomingCallTypeModel selectedTypeModel) async {
    await _appPreferences.setIncomingCallType(selectedTypeModel.incomingCallType);

    switch (selectedTypeModel.incomingCallType) {
      case IncomingCallType.pushNotification:
        await _callkeepBackgroundService.stopService();
        break;
      case IncomingCallType.socket:
        await _callkeepBackgroundService.startService();
        break;
    }

    _initializeActiveIncomingType();
  }
}
