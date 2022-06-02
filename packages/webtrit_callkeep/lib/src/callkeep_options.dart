import 'callkeep_handle.dart';

class CallkeepOptions {
  const CallkeepOptions({
    required this.ios,
  });

  final CallkeepIOSOptions ios;
}

class CallkeepIOSOptions {
  const CallkeepIOSOptions({
    required this.localizedName,
    this.ringtoneSound,
    this.iconTemplateImageAssetName,
    required this.maximumCallGroups,
    required this.maximumCallsPerCallGroup,
    required this.supportedHandleTypes,
    this.supportsVideo = false,
    this.includesCallsInRecents = true,
  });

  final String localizedName;
  final String? ringtoneSound;
  final String? iconTemplateImageAssetName;
  final int maximumCallGroups;
  final int maximumCallsPerCallGroup;
  final Set<CallkeepHandleType> supportedHandleTypes;
  final bool supportsVideo;
  final bool includesCallsInRecents;
}
