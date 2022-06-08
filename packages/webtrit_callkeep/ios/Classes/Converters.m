#import "Converters.h"

@implementation NSData (NSData_Conversion)
- (NSString *)toHexString {
  const unsigned char *dataBuffer = (const unsigned char *) [self bytes];
  if (!dataBuffer) {
    return [NSString string];
  } else {
    NSUInteger dataLength = [self length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i) {
      [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long) dataBuffer[i]]];
    }
    return [NSString stringWithString:hexString];
  }
}
@end

extern WTPHandleTypeEnum INPersonHandleTypeToPigeon(INPersonHandleType value) {
  switch (value) {
    case INPersonHandleTypeUnknown:
      return WTPHandleTypeEnumGeneric;
    case INPersonHandleTypePhoneNumber:
      return WTPHandleTypeEnumNumber;
    case INPersonHandleTypeEmailAddress:
      return WTPHandleTypeEnumEmail;
    default:
      return WTPHandleTypeEnumGeneric;
  }
}

@implementation INPersonHandle (INPersonHandle_Conversion)
- (WTPHandle *)toPigeon {
  return [WTPHandle makeWithType:INPersonHandleTypeToPigeon(self.type)
                           value:self.value];
}
@end

WTPIncomingCallErrorEnum CXErrorCodeIncomingCallErrorToPigeon(CXErrorCodeIncomingCallError value) {
  switch (value) {
    case CXErrorCodeIncomingCallErrorUnknown:
      return WTPIncomingCallErrorEnumUnknown;
    case CXErrorCodeIncomingCallErrorUnentitled:
      return WTPIncomingCallErrorEnumUnentitled;
    case CXErrorCodeIncomingCallErrorCallUUIDAlreadyExists:
      return WTPIncomingCallErrorEnumCallUuidAlreadyExists;
    case CXErrorCodeIncomingCallErrorFilteredByDoNotDisturb:
      return WTPIncomingCallErrorEnumFilteredByDoNotDisturb;
    case CXErrorCodeIncomingCallErrorFilteredByBlockList:
      return WTPIncomingCallErrorEnumFilteredByBlockList;
    default:
      return WTPIncomingCallErrorEnumInternal;
  }
}

extern WTPCallRequestErrorEnum CXErrorCodeRequestTransactionErrorToPigeon(CXErrorCodeRequestTransactionError value) {
  switch (value) {
    case CXErrorCodeRequestTransactionErrorUnknown:
      return WTPCallRequestErrorEnumUnknown;
    case CXErrorCodeRequestTransactionErrorUnentitled:
      return WTPCallRequestErrorEnumUnentitled;
    case CXErrorCodeRequestTransactionErrorUnknownCallProvider:
      return WTPCallRequestErrorEnumInternal;
    case CXErrorCodeRequestTransactionErrorEmptyTransaction:
      return WTPCallRequestErrorEnumInternal;
    case CXErrorCodeRequestTransactionErrorUnknownCallUUID:
      return WTPCallRequestErrorEnumUnknownCallUuid;
    case CXErrorCodeRequestTransactionErrorCallUUIDAlreadyExists:
      return WTPCallRequestErrorEnumCallUuidAlreadyExists;
    case CXErrorCodeRequestTransactionErrorInvalidAction:
      return WTPCallRequestErrorEnumInternal;
    case CXErrorCodeRequestTransactionErrorMaximumCallGroupsReached:
      return WTPCallRequestErrorEnumMaximumCallGroupsReached;
    default:
      return WTPCallRequestErrorEnumInternal;
  }
}

CXHandleType CXHandleTypeFromString(NSString *value) {
  if ([value isEqualToString:@"generic"]) {
    return CXHandleTypeGeneric;
  } else if ([value isEqualToString:@"number"]) {
    return CXHandleTypePhoneNumber;
  } else if ([value isEqualToString:@"email"]) {
    return CXHandleTypeEmailAddress;
  } else {
    return CXHandleTypeGeneric;
  }
}

WTPHandleTypeEnum CXHandleTypeToPigeon(CXHandleType value) {
  switch (value) {
    case CXHandleTypeGeneric:
      return WTPHandleTypeEnumGeneric;
    case CXHandleTypePhoneNumber:
      return WTPHandleTypeEnumNumber;
    case CXHandleTypeEmailAddress:
      return WTPHandleTypeEnumEmail;
    default:
      return WTPHandleTypeEnumGeneric;
  }
}

extern CXHandleType WTPHandleTypeEnumToCallKit(WTPHandleTypeEnum value) {
  switch (value) {
    case WTPHandleTypeEnumGeneric:
      return CXHandleTypeGeneric;
    case WTPHandleTypeEnumNumber:
      return CXHandleTypePhoneNumber;
    case WTPHandleTypeEnumEmail:
      return CXHandleTypeEmailAddress;
    default:
      return CXHandleTypeGeneric;
  }
}

@implementation CXHandle (CXHandle_Converters)
- (WTPHandle *)toPigeon {
  return [WTPHandle makeWithType:CXHandleTypeToPigeon(self.type)
                           value:self.value];
}
@end

@implementation WTPHandle (WTPHandle_Converters)
- (CXHandle *)toCallKit {
  return [[CXHandle alloc] initWithType:WTPHandleTypeEnumToCallKit(self.type)
                                  value:self.value];
}
@end

@implementation WTPEndCallReason (WTPEndCallReason_Converters)
- (CXCallEndedReason)toCallKit {
  switch ([self value]) {
    case WTPEndCallReasonEnumFailed:
      return CXCallEndedReasonFailed;
    case WTPEndCallReasonEnumRemoteEnded:
    case WTPEndCallReasonEnumMissed:
      return CXCallEndedReasonRemoteEnded;
    case WTPEndCallReasonEnumUnanswered:
      return CXCallEndedReasonUnanswered;
    case WTPEndCallReasonEnumAnsweredElsewhere:
      return CXCallEndedReasonAnsweredElsewhere;
    case WTPEndCallReasonEnumDeclinedElsewhere:
      return CXCallEndedReasonDeclinedElsewhere;
    default:
      return CXCallEndedReasonFailed;
  }
}
@end

@implementation WTPIOSOptions (WTPIOSOptions_Converters)
- (CXProviderConfiguration *)toCallKitWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  CXProviderConfiguration *providerConfiguration = [[CXProviderConfiguration alloc] initWithLocalizedName:self.localizedName];
  if (self.ringtoneSound != nil) {
    NSString *ringtoneSoundAssetKey = [registrar lookupKeyForAsset:self.ringtoneSound];
    providerConfiguration.ringtoneSound = ringtoneSoundAssetKey;
  }
  if (self.iconTemplateImageAssetName != nil) {
    NSString *iconTemplateImageAssetKey = [registrar lookupKeyForAsset:self.iconTemplateImageAssetName];
    providerConfiguration.iconTemplateImageData = UIImagePNGRepresentation([UIImage imageNamed:iconTemplateImageAssetKey]);
  }
  providerConfiguration.maximumCallGroups = self.maximumCallGroups.unsignedIntValue;
  providerConfiguration.maximumCallsPerCallGroup = self.maximumCallsPerCallGroup.unsignedIntValue;
  NSMutableSet<NSNumber *> *supportedHandleTypes = [NSMutableSet set];
  if (self.supportsHandleTypeGeneric != nil && self.supportsHandleTypeGeneric.boolValue == YES) {
    [supportedHandleTypes addObject:[NSNumber numberWithInteger:CXHandleTypeGeneric]];
  }
  if (self.supportsHandleTypePhoneNumber != nil && self.supportsHandleTypePhoneNumber.boolValue == YES) {
    [supportedHandleTypes addObject:[NSNumber numberWithInteger:CXHandleTypePhoneNumber]];
  }
  if (self.supportsHandleTypeEmailAddress != nil && self.supportsHandleTypeEmailAddress.boolValue == YES) {
    [supportedHandleTypes addObject:[NSNumber numberWithInteger:CXHandleTypeEmailAddress]];
  }
  providerConfiguration.supportedHandleTypes = supportedHandleTypes;
  providerConfiguration.supportsVideo = self.supportsVideo.boolValue;
  if (@available(iOS 11.0, *)) {
    providerConfiguration.includesCallsInRecents = self.includesCallsInRecents.boolValue;
  }
  return providerConfiguration;
}
@end
