import 'package:bloc/bloc.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/incoming_call_type/incoming_call_type_repository.dart';

import '../models/models.dart';

part 'network_state.dart';

part 'network_cubit.freezed.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(this._callTriggerConfig, this._deviceInfo, this._incomingCallTypeRepository, this._callkeepBackgroundService)
    : super(NetworkState(smsFallbackEnabled: _callTriggerConfig.smsFallback.enabled)) {
    _initializeActiveIncomingType();
  }

  final CallTriggerConfig _callTriggerConfig;
  final DeviceInfo _deviceInfo;
  final IncomingCallTypeRepository _incomingCallTypeRepository;
  final BackgroundSignalingBootstrapService _callkeepBackgroundService;

  bool get smsFallbackAvailable => _callTriggerConfig.smsFallback.available;

  void _initializeActiveIncomingType() {
    final currentType = _incomingCallTypeRepository.getIncomingCallType();

    final models = _buildIncomingCallTypeModels(currentType);

    final incomingCallTypesRemainder = _buildIncomingCallTypesRemainder();

    emit(state.copyWith(incomingCallTypeModels: models, incomingCallTypesRemainder: incomingCallTypesRemainder));
  }

  List<IncomingCallTypeModel> _buildIncomingCallTypeModels(IncomingCallType currentType) {
    return IncomingCallType.values.map((type) => IncomingCallTypeModel(type, type == currentType)).toList();
  }

  List<IncomingCallType> _buildIncomingCallTypesRemainder() {
    return _isAndroid14OrAbove() ? [IncomingCallType.socket] : <IncomingCallType>[];
  }

  bool _isAndroid14OrAbove() {
    return (_deviceInfo.sdkVersion ?? 0) >= 34;
  }

  Future<void> selectIncomingCallType(IncomingCallTypeModel selectedTypeModel) async {
    await _incomingCallTypeRepository.setIncomingCallType(selectedTypeModel.incomingCallType);

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
