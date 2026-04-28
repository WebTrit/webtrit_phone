import 'package:collection/collection.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

enum CallAudioDeviceType { earpiece, speaker, bluetooth, wiredHeadset, streaming, unknown }

class CallAudioDevice {
  const CallAudioDevice({required this.type, this.id, this.name});

  final CallAudioDeviceType type;
  final String? id;
  final String? name;

  factory CallAudioDevice.fromMediaInput(MediaDeviceInfo device) {
    return CallAudioDevice(
      type: switch (device.groupId) {
        'MicrophoneBuiltIn' => CallAudioDeviceType.earpiece,
        'MicrophoneWired' || 'LineIn' || 'USBAudio' => CallAudioDeviceType.wiredHeadset,
        'BluetoothHFP' => CallAudioDeviceType.bluetooth,
        'CarAudio' => CallAudioDeviceType.streaming,
        _ => CallAudioDeviceType.unknown,
      },
      name: device.label,
      id: device.deviceId,
    );
  }

  factory CallAudioDevice.fromMediaOutput(MediaDeviceInfo device) {
    return CallAudioDevice(
      type: switch (device.groupId) {
        'Speaker' => CallAudioDeviceType.speaker,
        'Receiver' => CallAudioDeviceType.earpiece,
        'BluetoothA2DPOutput' || 'BluetoothHFP' || 'BluetoothLE' => CallAudioDeviceType.bluetooth,
        'Headphones' || 'LineOut' || 'USBAudio' => CallAudioDeviceType.wiredHeadset,
        'CarAudio' => CallAudioDeviceType.streaming,
        _ => CallAudioDeviceType.unknown,
      },
      name: device.label,
      id: device.deviceId,
    );
  }

  factory CallAudioDevice.fromCallkeep(CallkeepAudioDevice device) {
    return CallAudioDevice(
      type: switch (device.type) {
        CallkeepAudioDeviceType.earpiece => CallAudioDeviceType.earpiece,
        CallkeepAudioDeviceType.speaker => CallAudioDeviceType.speaker,
        CallkeepAudioDeviceType.bluetooth => CallAudioDeviceType.bluetooth,
        CallkeepAudioDeviceType.wiredHeadset => CallAudioDeviceType.wiredHeadset,
        CallkeepAudioDeviceType.streaming => CallAudioDeviceType.streaming,
        CallkeepAudioDeviceType.unknown => CallAudioDeviceType.unknown,
      },
      id: device.id,
      name: device.name,
    );
  }

  CallkeepAudioDevice toCallkeep() {
    return CallkeepAudioDevice(
      type: switch (type) {
        CallAudioDeviceType.earpiece => CallkeepAudioDeviceType.earpiece,
        CallAudioDeviceType.speaker => CallkeepAudioDeviceType.speaker,
        CallAudioDeviceType.bluetooth => CallkeepAudioDeviceType.bluetooth,
        CallAudioDeviceType.wiredHeadset => CallkeepAudioDeviceType.wiredHeadset,
        CallAudioDeviceType.streaming => CallkeepAudioDeviceType.streaming,
        CallAudioDeviceType.unknown => CallkeepAudioDeviceType.unknown,
      },
      id: id,
      name: name,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CallAudioDevice && type == other.type && id == other.id && name == other.name;

  @override
  int get hashCode => Object.hash(type, id, name);

  @override
  String toString() => 'CallAudioDevice(type: $type, id: $id, name: $name)';
}

extension CallAudioDeviceIterableExtension<T extends CallAudioDevice> on Iterable<T> {
  bool get onlyBuiltIn =>
      every((device) => device.type == CallAudioDeviceType.earpiece || device.type == CallAudioDeviceType.speaker);

  T? get getSpeaker => firstWhereOrNull((device) => device.type == CallAudioDeviceType.speaker);

  T? get getEarpiece => firstWhereOrNull((device) => device.type == CallAudioDeviceType.earpiece);
}
