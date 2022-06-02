import 'callkeep.pigeon.dart';
import '../callkeep.dart';
import '../callkeep_handle.dart';
import '../callkeep_options.dart';

extension PHandleTypeEnumConverter on PHandleTypeEnum {
  CallkeepHandleType toCallkeep() {
    switch (this) {
      case PHandleTypeEnum.generic:
        return CallkeepHandleType.generic;
      case PHandleTypeEnum.number:
        return CallkeepHandleType.number;
      case PHandleTypeEnum.email:
        return CallkeepHandleType.email;
    }
  }
}

extension PHandleConverter on PHandle {
  CallkeepHandle toCallkeep() {
    return CallkeepHandle(
      type: type.toCallkeep(),
      value: value,
    );
  }
}

extension PIncomingCallErrorEnumConverter on PIncomingCallErrorEnum {
  CallkeepIncomingCallError toCallkeep() {
    switch (this) {
      case PIncomingCallErrorEnum.unknown:
        return CallkeepIncomingCallError.unknown;
      case PIncomingCallErrorEnum.unentitled:
        return CallkeepIncomingCallError.unentitled;
      case PIncomingCallErrorEnum.callUuidAlreadyExists:
        return CallkeepIncomingCallError.callUuidAlreadyExists;
      case PIncomingCallErrorEnum.filteredByDoNotDisturb:
        return CallkeepIncomingCallError.filteredByDoNotDisturb;
      case PIncomingCallErrorEnum.filteredByBlockList:
        return CallkeepIncomingCallError.filteredByBlockList;
    }
  }
}

extension CallkeepHandleTypeConverter on CallkeepHandleType {
  PHandleTypeEnum toPigeon() {
    switch (this) {
      case CallkeepHandleType.generic:
        return PHandleTypeEnum.generic;
      case CallkeepHandleType.number:
        return PHandleTypeEnum.number;
      case CallkeepHandleType.email:
        return PHandleTypeEnum.email;
    }
  }
}

extension CallkeepHandleConverter on CallkeepHandle {
  PHandle toPigeon() {
    return PHandle(
      type: type.toPigeon(),
      value: value,
    );
  }
}

extension CallkeepEndCallReasonConverter on CallkeepEndCallReason {
  PEndCallReasonEnum toPigeon() {
    switch (this) {
      case CallkeepEndCallReason.failed:
        return PEndCallReasonEnum.failed;
      case CallkeepEndCallReason.remoteEnded:
        return PEndCallReasonEnum.remoteEnded;
      case CallkeepEndCallReason.unanswered:
        return PEndCallReasonEnum.unanswered;
      case CallkeepEndCallReason.answeredElsewhere:
        return PEndCallReasonEnum.answeredElsewhere;
      case CallkeepEndCallReason.declinedElsewhere:
        return PEndCallReasonEnum.declinedElsewhere;
      case CallkeepEndCallReason.missed:
        return PEndCallReasonEnum.missed;
    }
  }
}

extension CallkeepOptionsConverter on CallkeepOptions {
  POptions toPigeon() {
    return POptions(
      ios: ios.toPigeon(),
    );
  }
}

extension CallkeepIOSOptionsConverter on CallkeepIOSOptions {
  PIOSOptions toPigeon() {
    return PIOSOptions(
      localizedName: localizedName,
      ringtoneSound: ringtoneSound,
      iconTemplateImageAssetName: iconTemplateImageAssetName,
      maximumCallGroups: maximumCallGroups,
      maximumCallsPerCallGroup: maximumCallsPerCallGroup,
      supportsHandleTypeGeneric: supportedHandleTypes.contains(CallkeepHandleType.generic),
      supportsHandleTypePhoneNumber: supportedHandleTypes.contains(CallkeepHandleType.number),
      supportsHandleTypeEmailAddress: supportedHandleTypes.contains(CallkeepHandleType.email),
      supportsVideo: supportsVideo,
      includesCallsInRecents: includesCallsInRecents,
    );
  }
}
