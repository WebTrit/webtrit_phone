// Autogenerated from Pigeon (v3.1.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "Generated.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ?: [NSNull null]),
        @"message": (error.message ?: [NSNull null]),
        @"details": (error.details ?: [NSNull null]),
        };
  }
  return @{
      @"result": (result ?: [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray* array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}


@interface WTPIOSOptions ()
+ (WTPIOSOptions *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface WTPOptions ()
+ (WTPOptions *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface WTPHandle ()
+ (WTPHandle *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface WTPEndCallReason ()
+ (WTPEndCallReason *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface WTPIncomingCallError ()
+ (WTPIncomingCallError *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface WTPCallRequestError ()
+ (WTPCallRequestError *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation WTPIOSOptions
+ (instancetype)makeWithLocalizedName:(NSString *)localizedName
    ringtoneSound:(nullable NSString *)ringtoneSound
    iconTemplateImageAssetName:(nullable NSString *)iconTemplateImageAssetName
    maximumCallGroups:(NSNumber *)maximumCallGroups
    maximumCallsPerCallGroup:(NSNumber *)maximumCallsPerCallGroup
    supportsHandleTypeGeneric:(nullable NSNumber *)supportsHandleTypeGeneric
    supportsHandleTypePhoneNumber:(nullable NSNumber *)supportsHandleTypePhoneNumber
    supportsHandleTypeEmailAddress:(nullable NSNumber *)supportsHandleTypeEmailAddress
    supportsVideo:(NSNumber *)supportsVideo
    includesCallsInRecents:(NSNumber *)includesCallsInRecents {
  WTPIOSOptions* pigeonResult = [[WTPIOSOptions alloc] init];
  pigeonResult.localizedName = localizedName;
  pigeonResult.ringtoneSound = ringtoneSound;
  pigeonResult.iconTemplateImageAssetName = iconTemplateImageAssetName;
  pigeonResult.maximumCallGroups = maximumCallGroups;
  pigeonResult.maximumCallsPerCallGroup = maximumCallsPerCallGroup;
  pigeonResult.supportsHandleTypeGeneric = supportsHandleTypeGeneric;
  pigeonResult.supportsHandleTypePhoneNumber = supportsHandleTypePhoneNumber;
  pigeonResult.supportsHandleTypeEmailAddress = supportsHandleTypeEmailAddress;
  pigeonResult.supportsVideo = supportsVideo;
  pigeonResult.includesCallsInRecents = includesCallsInRecents;
  return pigeonResult;
}
+ (WTPIOSOptions *)fromMap:(NSDictionary *)dict {
  WTPIOSOptions *pigeonResult = [[WTPIOSOptions alloc] init];
  pigeonResult.localizedName = GetNullableObject(dict, @"localizedName");
  NSAssert(pigeonResult.localizedName != nil, @"");
  pigeonResult.ringtoneSound = GetNullableObject(dict, @"ringtoneSound");
  pigeonResult.iconTemplateImageAssetName = GetNullableObject(dict, @"iconTemplateImageAssetName");
  pigeonResult.maximumCallGroups = GetNullableObject(dict, @"maximumCallGroups");
  NSAssert(pigeonResult.maximumCallGroups != nil, @"");
  pigeonResult.maximumCallsPerCallGroup = GetNullableObject(dict, @"maximumCallsPerCallGroup");
  NSAssert(pigeonResult.maximumCallsPerCallGroup != nil, @"");
  pigeonResult.supportsHandleTypeGeneric = GetNullableObject(dict, @"supportsHandleTypeGeneric");
  pigeonResult.supportsHandleTypePhoneNumber = GetNullableObject(dict, @"supportsHandleTypePhoneNumber");
  pigeonResult.supportsHandleTypeEmailAddress = GetNullableObject(dict, @"supportsHandleTypeEmailAddress");
  pigeonResult.supportsVideo = GetNullableObject(dict, @"supportsVideo");
  NSAssert(pigeonResult.supportsVideo != nil, @"");
  pigeonResult.includesCallsInRecents = GetNullableObject(dict, @"includesCallsInRecents");
  NSAssert(pigeonResult.includesCallsInRecents != nil, @"");
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return @{
    @"localizedName" : (self.localizedName ?: [NSNull null]),
    @"ringtoneSound" : (self.ringtoneSound ?: [NSNull null]),
    @"iconTemplateImageAssetName" : (self.iconTemplateImageAssetName ?: [NSNull null]),
    @"maximumCallGroups" : (self.maximumCallGroups ?: [NSNull null]),
    @"maximumCallsPerCallGroup" : (self.maximumCallsPerCallGroup ?: [NSNull null]),
    @"supportsHandleTypeGeneric" : (self.supportsHandleTypeGeneric ?: [NSNull null]),
    @"supportsHandleTypePhoneNumber" : (self.supportsHandleTypePhoneNumber ?: [NSNull null]),
    @"supportsHandleTypeEmailAddress" : (self.supportsHandleTypeEmailAddress ?: [NSNull null]),
    @"supportsVideo" : (self.supportsVideo ?: [NSNull null]),
    @"includesCallsInRecents" : (self.includesCallsInRecents ?: [NSNull null]),
  };
}
@end

@implementation WTPOptions
+ (instancetype)makeWithIos:(WTPIOSOptions *)ios {
  WTPOptions* pigeonResult = [[WTPOptions alloc] init];
  pigeonResult.ios = ios;
  return pigeonResult;
}
+ (WTPOptions *)fromMap:(NSDictionary *)dict {
  WTPOptions *pigeonResult = [[WTPOptions alloc] init];
  pigeonResult.ios = [WTPIOSOptions fromMap:GetNullableObject(dict, @"ios")];
  NSAssert(pigeonResult.ios != nil, @"");
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return @{
    @"ios" : (self.ios ? [self.ios toMap] : [NSNull null]),
  };
}
@end

@implementation WTPHandle
+ (instancetype)makeWithType:(WTPHandleTypeEnum)type
    value:(NSString *)value {
  WTPHandle* pigeonResult = [[WTPHandle alloc] init];
  pigeonResult.type = type;
  pigeonResult.value = value;
  return pigeonResult;
}
+ (WTPHandle *)fromMap:(NSDictionary *)dict {
  WTPHandle *pigeonResult = [[WTPHandle alloc] init];
  pigeonResult.type = [GetNullableObject(dict, @"type") integerValue];
  pigeonResult.value = GetNullableObject(dict, @"value");
  NSAssert(pigeonResult.value != nil, @"");
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return @{
    @"type" : @(self.type),
    @"value" : (self.value ?: [NSNull null]),
  };
}
@end

@implementation WTPEndCallReason
+ (instancetype)makeWithValue:(WTPEndCallReasonEnum)value {
  WTPEndCallReason* pigeonResult = [[WTPEndCallReason alloc] init];
  pigeonResult.value = value;
  return pigeonResult;
}
+ (WTPEndCallReason *)fromMap:(NSDictionary *)dict {
  WTPEndCallReason *pigeonResult = [[WTPEndCallReason alloc] init];
  pigeonResult.value = [GetNullableObject(dict, @"value") integerValue];
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return @{
    @"value" : @(self.value),
  };
}
@end

@implementation WTPIncomingCallError
+ (instancetype)makeWithValue:(WTPIncomingCallErrorEnum)value {
  WTPIncomingCallError* pigeonResult = [[WTPIncomingCallError alloc] init];
  pigeonResult.value = value;
  return pigeonResult;
}
+ (WTPIncomingCallError *)fromMap:(NSDictionary *)dict {
  WTPIncomingCallError *pigeonResult = [[WTPIncomingCallError alloc] init];
  pigeonResult.value = [GetNullableObject(dict, @"value") integerValue];
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return @{
    @"value" : @(self.value),
  };
}
@end

@implementation WTPCallRequestError
+ (instancetype)makeWithValue:(WTPCallRequestErrorEnum)value {
  WTPCallRequestError* pigeonResult = [[WTPCallRequestError alloc] init];
  pigeonResult.value = value;
  return pigeonResult;
}
+ (WTPCallRequestError *)fromMap:(NSDictionary *)dict {
  WTPCallRequestError *pigeonResult = [[WTPCallRequestError alloc] init];
  pigeonResult.value = [GetNullableObject(dict, @"value") integerValue];
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return @{
    @"value" : @(self.value),
  };
}
@end

@interface WTPHostApiCodecReader : FlutterStandardReader
@end
@implementation WTPHostApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [WTPCallRequestError fromMap:[self readValue]];
    
    case 129:     
      return [WTPEndCallReason fromMap:[self readValue]];
    
    case 130:     
      return [WTPHandle fromMap:[self readValue]];
    
    case 131:     
      return [WTPHandle fromMap:[self readValue]];
    
    case 132:     
      return [WTPIOSOptions fromMap:[self readValue]];
    
    case 133:     
      return [WTPIncomingCallError fromMap:[self readValue]];
    
    case 134:     
      return [WTPOptions fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface WTPHostApiCodecWriter : FlutterStandardWriter
@end
@implementation WTPHostApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[WTPCallRequestError class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[WTPEndCallReason class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[WTPHandle class]]) {
    [self writeByte:130];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[WTPHandle class]]) {
    [self writeByte:131];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[WTPIOSOptions class]]) {
    [self writeByte:132];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[WTPIncomingCallError class]]) {
    [self writeByte:133];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[WTPOptions class]]) {
    [self writeByte:134];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface WTPHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation WTPHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[WTPHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[WTPHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *WTPHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    WTPHostApiCodecReaderWriter *readerWriter = [[WTPHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void WTPHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<WTPHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.isSetUp"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isSetUp:)], @"WTPHostApi api (%@) doesn't respond to @selector(isSetUp:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api isSetUp:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.setUp"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setUp:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(setUp:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        WTPOptions *arg_options = GetNullableObjectAtIndex(args, 0);
        [api setUp:arg_options completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.tearDown"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(tearDown:)], @"WTPHostApi api (%@) doesn't respond to @selector(tearDown:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api tearDown:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.reportNewIncomingCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(reportNewIncomingCall:handle:displayName:hasVideo:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(reportNewIncomingCall:handle:displayName:hasVideo:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        WTPHandle *arg_handle = GetNullableObjectAtIndex(args, 1);
        NSString *arg_displayName = GetNullableObjectAtIndex(args, 2);
        NSNumber *arg_hasVideo = GetNullableObjectAtIndex(args, 3);
        [api reportNewIncomingCall:arg_uuidString handle:arg_handle displayName:arg_displayName hasVideo:arg_hasVideo completion:^(WTPIncomingCallError *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.reportConnectingOutgoingCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(reportConnectingOutgoingCall:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(reportConnectingOutgoingCall:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        [api reportConnectingOutgoingCall:arg_uuidString completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.reportConnectedOutgoingCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(reportConnectedOutgoingCall:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(reportConnectedOutgoingCall:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        [api reportConnectedOutgoingCall:arg_uuidString completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.reportUpdateCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(reportUpdateCall:handle:displayName:hasVideo:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(reportUpdateCall:handle:displayName:hasVideo:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        WTPHandle *arg_handle = GetNullableObjectAtIndex(args, 1);
        NSString *arg_displayName = GetNullableObjectAtIndex(args, 2);
        NSNumber *arg_hasVideo = GetNullableObjectAtIndex(args, 3);
        [api reportUpdateCall:arg_uuidString handle:arg_handle displayName:arg_displayName hasVideo:arg_hasVideo completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.reportEndCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(reportEndCall:reason:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(reportEndCall:reason:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        WTPEndCallReason *arg_reason = GetNullableObjectAtIndex(args, 1);
        [api reportEndCall:arg_uuidString reason:arg_reason completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.startCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(startCall:handle:displayNameOrContactIdentifier:video:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(startCall:handle:displayNameOrContactIdentifier:video:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        WTPHandle *arg_handle = GetNullableObjectAtIndex(args, 1);
        NSString *arg_displayNameOrContactIdentifier = GetNullableObjectAtIndex(args, 2);
        NSNumber *arg_video = GetNullableObjectAtIndex(args, 3);
        [api startCall:arg_uuidString handle:arg_handle displayNameOrContactIdentifier:arg_displayNameOrContactIdentifier video:arg_video completion:^(WTPCallRequestError *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.answerCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(answerCall:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(answerCall:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        [api answerCall:arg_uuidString completion:^(WTPCallRequestError *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.endCall"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(endCall:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(endCall:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        [api endCall:arg_uuidString completion:^(WTPCallRequestError *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.setHeld"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setHeld:onHold:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(setHeld:onHold:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_onHold = GetNullableObjectAtIndex(args, 1);
        [api setHeld:arg_uuidString onHold:arg_onHold completion:^(WTPCallRequestError *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.setMuted"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setMuted:muted:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(setMuted:muted:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_muted = GetNullableObjectAtIndex(args, 1);
        [api setMuted:arg_uuidString muted:arg_muted completion:^(WTPCallRequestError *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PHostApi.sendDTMF"
        binaryMessenger:binaryMessenger
        codec:WTPHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(sendDTMF:key:completion:)], @"WTPHostApi api (%@) doesn't respond to @selector(sendDTMF:key:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_uuidString = GetNullableObjectAtIndex(args, 0);
        NSString *arg_key = GetNullableObjectAtIndex(args, 1);
        [api sendDTMF:arg_uuidString key:arg_key completion:^(WTPCallRequestError *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface WTPDelegateFlutterApiCodecReader : FlutterStandardReader
@end
@implementation WTPDelegateFlutterApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [WTPHandle fromMap:[self readValue]];
    
    case 129:     
      return [WTPIncomingCallError fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface WTPDelegateFlutterApiCodecWriter : FlutterStandardWriter
@end
@implementation WTPDelegateFlutterApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[WTPHandle class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[WTPIncomingCallError class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface WTPDelegateFlutterApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation WTPDelegateFlutterApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[WTPDelegateFlutterApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[WTPDelegateFlutterApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *WTPDelegateFlutterApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    WTPDelegateFlutterApiCodecReaderWriter *readerWriter = [[WTPDelegateFlutterApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


@interface WTPDelegateFlutterApi ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation WTPDelegateFlutterApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)continueStartCallIntentHandle:(WTPHandle *)arg_handle displayName:(nullable NSString *)arg_displayName video:(NSNumber *)arg_video completion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.continueStartCallIntent"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_handle ?: [NSNull null], arg_displayName ?: [NSNull null], arg_video ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
- (void)didPushIncomingCallHandle:(WTPHandle *)arg_handle displayName:(nullable NSString *)arg_displayName video:(NSNumber *)arg_video callId:(NSString *)arg_callId uuid:(NSString *)arg_uuidString error:(nullable WTPIncomingCallError *)arg_error completion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.didPushIncomingCall"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_handle ?: [NSNull null], arg_displayName ?: [NSNull null], arg_video ?: [NSNull null], arg_callId ?: [NSNull null], arg_uuidString ?: [NSNull null], arg_error ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
- (void)performStartCall:(NSString *)arg_uuidString handle:(WTPHandle *)arg_handle displayNameOrContactIdentifier:(nullable NSString *)arg_displayNameOrContactIdentifier video:(NSNumber *)arg_video completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.performStartCall"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_uuidString ?: [NSNull null], arg_handle ?: [NSNull null], arg_displayNameOrContactIdentifier ?: [NSNull null], arg_video ?: [NSNull null]] reply:^(id reply) {
    NSNumber *output = reply;
    completion(output, nil);
  }];
}
- (void)performAnswerCall:(NSString *)arg_uuidString completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.performAnswerCall"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_uuidString ?: [NSNull null]] reply:^(id reply) {
    NSNumber *output = reply;
    completion(output, nil);
  }];
}
- (void)performEndCall:(NSString *)arg_uuidString completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.performEndCall"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_uuidString ?: [NSNull null]] reply:^(id reply) {
    NSNumber *output = reply;
    completion(output, nil);
  }];
}
- (void)performSetHeld:(NSString *)arg_uuidString onHold:(NSNumber *)arg_onHold completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.performSetHeld"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_uuidString ?: [NSNull null], arg_onHold ?: [NSNull null]] reply:^(id reply) {
    NSNumber *output = reply;
    completion(output, nil);
  }];
}
- (void)performSetMuted:(NSString *)arg_uuidString muted:(NSNumber *)arg_muted completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.performSetMuted"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_uuidString ?: [NSNull null], arg_muted ?: [NSNull null]] reply:^(id reply) {
    NSNumber *output = reply;
    completion(output, nil);
  }];
}
- (void)performSendDTMF:(NSString *)arg_uuidString key:(NSString *)arg_key completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.performSendDTMF"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_uuidString ?: [NSNull null], arg_key ?: [NSNull null]] reply:^(id reply) {
    NSNumber *output = reply;
    completion(output, nil);
  }];
}
- (void)didActivateAudioSession:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.didActivateAudioSession"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:nil reply:^(id reply) {
    completion(nil);
  }];
}
- (void)didDeactivateAudioSession:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.didDeactivateAudioSession"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:nil reply:^(id reply) {
    completion(nil);
  }];
}
- (void)didReset:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PDelegateFlutterApi.didReset"
      binaryMessenger:self.binaryMessenger
      codec:WTPDelegateFlutterApiGetCodec()];
  [channel sendMessage:nil reply:^(id reply) {
    completion(nil);
  }];
}
@end
@interface WTPPushRegistryHostApiCodecReader : FlutterStandardReader
@end
@implementation WTPPushRegistryHostApiCodecReader
@end

@interface WTPPushRegistryHostApiCodecWriter : FlutterStandardWriter
@end
@implementation WTPPushRegistryHostApiCodecWriter
@end

@interface WTPPushRegistryHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation WTPPushRegistryHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[WTPPushRegistryHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[WTPPushRegistryHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *WTPPushRegistryHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    WTPPushRegistryHostApiCodecReaderWriter *readerWriter = [[WTPPushRegistryHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void WTPPushRegistryHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<WTPPushRegistryHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PPushRegistryHostApi.pushTokenForPushTypeVoIP"
        binaryMessenger:binaryMessenger
        codec:WTPPushRegistryHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(pushTokenForPushTypeVoIP:)], @"WTPPushRegistryHostApi api (%@) doesn't respond to @selector(pushTokenForPushTypeVoIP:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSString *output = [api pushTokenForPushTypeVoIP:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface WTPPushRegistryDelegateFlutterApiCodecReader : FlutterStandardReader
@end
@implementation WTPPushRegistryDelegateFlutterApiCodecReader
@end

@interface WTPPushRegistryDelegateFlutterApiCodecWriter : FlutterStandardWriter
@end
@implementation WTPPushRegistryDelegateFlutterApiCodecWriter
@end

@interface WTPPushRegistryDelegateFlutterApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation WTPPushRegistryDelegateFlutterApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[WTPPushRegistryDelegateFlutterApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[WTPPushRegistryDelegateFlutterApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *WTPPushRegistryDelegateFlutterApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    WTPPushRegistryDelegateFlutterApiCodecReaderWriter *readerWriter = [[WTPPushRegistryDelegateFlutterApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


@interface WTPPushRegistryDelegateFlutterApi ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation WTPPushRegistryDelegateFlutterApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)didUpdatePushTokenForPushTypeVoIP:(nullable NSString *)arg_token completion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PPushRegistryDelegateFlutterApi.didUpdatePushTokenForPushTypeVoIP"
      binaryMessenger:self.binaryMessenger
      codec:WTPPushRegistryDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[arg_token ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
@end
