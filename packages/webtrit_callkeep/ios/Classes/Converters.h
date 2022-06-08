#import <Flutter/Flutter.h>

#import <CallKit/CallKit.h>
#import <Intents/Intents.h>

#import "Generated.h"

@interface NSData (NSData_Conversion)
- (NSString *)toHexString;
@end

extern WTPHandleTypeEnum INPersonHandleTypeToPigeon(INPersonHandleType value);

@interface INPersonHandle (INPersonHandle_Conversion)
- (WTPHandle *)toPigeon;
@end

extern WTPIncomingCallErrorEnum CXErrorCodeIncomingCallErrorToPigeon(CXErrorCodeIncomingCallError value);

extern WTPCallRequestErrorEnum CXErrorCodeRequestTransactionErrorToPigeon(CXErrorCodeRequestTransactionError value);

extern CXHandleType CXHandleTypeFromString(NSString *value);

extern WTPHandleTypeEnum CXHandleTypeToPigeon(CXHandleType value);

extern CXHandleType WTPHandleTypeEnumToCallKit(WTPHandleTypeEnum value);

@interface CXHandle (CXHandle_Converters)
- (WTPHandle *)toPigeon;
@end

@interface WTPHandle (WTPHandle_Converters)
- (CXHandle *)toCallKit;
@end

@interface WTPEndCallReason (WTPEndCallReason_Converters)
- (CXCallEndedReason)toCallKit;
@end

@interface WTPIOSOptions (WTPIOSOptions_Converters)
- (CXProviderConfiguration *)toCallKitWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end

