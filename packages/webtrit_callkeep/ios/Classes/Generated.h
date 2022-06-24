// Autogenerated from Pigeon (v3.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WTPHandleTypeEnum) {
  WTPHandleTypeEnumGeneric = 0,
  WTPHandleTypeEnumNumber = 1,
  WTPHandleTypeEnumEmail = 2,
};

typedef NS_ENUM(NSUInteger, WTPEndCallReasonEnum) {
  WTPEndCallReasonEnumFailed = 0,
  WTPEndCallReasonEnumRemoteEnded = 1,
  WTPEndCallReasonEnumUnanswered = 2,
  WTPEndCallReasonEnumAnsweredElsewhere = 3,
  WTPEndCallReasonEnumDeclinedElsewhere = 4,
  WTPEndCallReasonEnumMissed = 5,
};

typedef NS_ENUM(NSUInteger, WTPIncomingCallErrorEnum) {
  WTPIncomingCallErrorEnumUnknown = 0,
  WTPIncomingCallErrorEnumUnentitled = 1,
  WTPIncomingCallErrorEnumCallUuidAlreadyExists = 2,
  WTPIncomingCallErrorEnumFilteredByDoNotDisturb = 3,
  WTPIncomingCallErrorEnumFilteredByBlockList = 4,
  WTPIncomingCallErrorEnumInternal = 5,
};

typedef NS_ENUM(NSUInteger, WTPCallRequestErrorEnum) {
  WTPCallRequestErrorEnumUnknown = 0,
  WTPCallRequestErrorEnumUnentitled = 1,
  WTPCallRequestErrorEnumUnknownCallUuid = 2,
  WTPCallRequestErrorEnumCallUuidAlreadyExists = 3,
  WTPCallRequestErrorEnumMaximumCallGroupsReached = 4,
  WTPCallRequestErrorEnumInternal = 5,
};

@class WTPIOSOptions;
@class WTPOptions;
@class WTPHandle;
@class WTPEndCallReason;
@class WTPIncomingCallError;
@class WTPCallRequestError;

@interface WTPIOSOptions : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithLocalizedName:(NSString *)localizedName
    ringtoneSound:(nullable NSString *)ringtoneSound
    iconTemplateImageAssetName:(nullable NSString *)iconTemplateImageAssetName
    maximumCallGroups:(NSNumber *)maximumCallGroups
    maximumCallsPerCallGroup:(NSNumber *)maximumCallsPerCallGroup
    supportsHandleTypeGeneric:(nullable NSNumber *)supportsHandleTypeGeneric
    supportsHandleTypePhoneNumber:(nullable NSNumber *)supportsHandleTypePhoneNumber
    supportsHandleTypeEmailAddress:(nullable NSNumber *)supportsHandleTypeEmailAddress
    supportsVideo:(NSNumber *)supportsVideo
    includesCallsInRecents:(NSNumber *)includesCallsInRecents;
@property(nonatomic, copy) NSString * localizedName;
@property(nonatomic, copy, nullable) NSString * ringtoneSound;
@property(nonatomic, copy, nullable) NSString * iconTemplateImageAssetName;
@property(nonatomic, strong) NSNumber * maximumCallGroups;
@property(nonatomic, strong) NSNumber * maximumCallsPerCallGroup;
@property(nonatomic, strong, nullable) NSNumber * supportsHandleTypeGeneric;
@property(nonatomic, strong, nullable) NSNumber * supportsHandleTypePhoneNumber;
@property(nonatomic, strong, nullable) NSNumber * supportsHandleTypeEmailAddress;
@property(nonatomic, strong) NSNumber * supportsVideo;
@property(nonatomic, strong) NSNumber * includesCallsInRecents;
@end

@interface WTPOptions : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithIos:(WTPIOSOptions *)ios;
@property(nonatomic, strong) WTPIOSOptions * ios;
@end

@interface WTPHandle : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithType:(WTPHandleTypeEnum)type
    value:(NSString *)value;
@property(nonatomic, assign) WTPHandleTypeEnum type;
@property(nonatomic, copy) NSString * value;
@end

@interface WTPEndCallReason : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(WTPEndCallReasonEnum)value;
@property(nonatomic, assign) WTPEndCallReasonEnum value;
@end

@interface WTPIncomingCallError : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(WTPIncomingCallErrorEnum)value;
@property(nonatomic, assign) WTPIncomingCallErrorEnum value;
@end

@interface WTPCallRequestError : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(WTPCallRequestErrorEnum)value;
@property(nonatomic, assign) WTPCallRequestErrorEnum value;
@end

/// The codec used by WTPHostApi.
NSObject<FlutterMessageCodec> *WTPHostApiGetCodec(void);

@protocol WTPHostApi
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)isSetUp:(FlutterError *_Nullable *_Nonnull)error;
- (void)setUp:(WTPOptions *)options completion:(void(^)(FlutterError *_Nullable))completion;
- (void)tearDown:(void(^)(FlutterError *_Nullable))completion;
- (void)reportNewIncomingCall:(NSString *)uuidString handle:(WTPHandle *)handle displayName:(nullable NSString *)displayName hasVideo:(NSNumber *)hasVideo completion:(void(^)(WTPIncomingCallError *_Nullable, FlutterError *_Nullable))completion;
- (void)reportConnectingOutgoingCall:(NSString *)uuidString completion:(void(^)(FlutterError *_Nullable))completion;
- (void)reportConnectedOutgoingCall:(NSString *)uuidString completion:(void(^)(FlutterError *_Nullable))completion;
- (void)reportUpdateCall:(NSString *)uuidString handle:(nullable WTPHandle *)handle displayName:(nullable NSString *)displayName hasVideo:(nullable NSNumber *)hasVideo completion:(void(^)(FlutterError *_Nullable))completion;
- (void)reportEndCall:(NSString *)uuidString reason:(WTPEndCallReason *)reason completion:(void(^)(FlutterError *_Nullable))completion;
- (void)startCall:(NSString *)uuidString handle:(WTPHandle *)handle displayNameOrContactIdentifier:(nullable NSString *)displayNameOrContactIdentifier video:(NSNumber *)video completion:(void(^)(WTPCallRequestError *_Nullable, FlutterError *_Nullable))completion;
- (void)answerCall:(NSString *)uuidString completion:(void(^)(WTPCallRequestError *_Nullable, FlutterError *_Nullable))completion;
- (void)endCall:(NSString *)uuidString completion:(void(^)(WTPCallRequestError *_Nullable, FlutterError *_Nullable))completion;
- (void)setHeld:(NSString *)uuidString onHold:(NSNumber *)onHold completion:(void(^)(WTPCallRequestError *_Nullable, FlutterError *_Nullable))completion;
- (void)setMuted:(NSString *)uuidString muted:(NSNumber *)muted completion:(void(^)(WTPCallRequestError *_Nullable, FlutterError *_Nullable))completion;
- (void)sendDTMF:(NSString *)uuidString key:(NSString *)key completion:(void(^)(WTPCallRequestError *_Nullable, FlutterError *_Nullable))completion;
@end

extern void WTPHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<WTPHostApi> *_Nullable api);

/// The codec used by WTPDelegateFlutterApi.
NSObject<FlutterMessageCodec> *WTPDelegateFlutterApiGetCodec(void);

@interface WTPDelegateFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)continueStartCallIntentHandle:(WTPHandle *)handle displayName:(nullable NSString *)displayName video:(NSNumber *)video completion:(void(^)(NSError *_Nullable))completion;
- (void)didPushIncomingCallHandle:(WTPHandle *)handle displayName:(nullable NSString *)displayName video:(NSNumber *)video callId:(NSString *)callId uuid:(NSString *)uuidString error:(nullable WTPIncomingCallError *)error completion:(void(^)(NSError *_Nullable))completion;
- (void)performStartCall:(NSString *)uuidString handle:(WTPHandle *)handle displayNameOrContactIdentifier:(nullable NSString *)displayNameOrContactIdentifier video:(NSNumber *)video completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion;
- (void)performAnswerCall:(NSString *)uuidString completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion;
- (void)performEndCall:(NSString *)uuidString completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion;
- (void)performSetHeld:(NSString *)uuidString onHold:(NSNumber *)onHold completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion;
- (void)performSetMuted:(NSString *)uuidString muted:(NSNumber *)muted completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion;
- (void)performSendDTMF:(NSString *)uuidString key:(NSString *)key completion:(void(^)(NSNumber *_Nullable, NSError *_Nullable))completion;
- (void)didActivateAudioSession:(void(^)(NSError *_Nullable))completion;
- (void)didDeactivateAudioSession:(void(^)(NSError *_Nullable))completion;
- (void)didReset:(void(^)(NSError *_Nullable))completion;
@end
/// The codec used by WTPPushRegistryHostApi.
NSObject<FlutterMessageCodec> *WTPPushRegistryHostApiGetCodec(void);

@protocol WTPPushRegistryHostApi
- (nullable NSString *)pushTokenForPushTypeVoIP:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void WTPPushRegistryHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<WTPPushRegistryHostApi> *_Nullable api);

/// The codec used by WTPPushRegistryDelegateFlutterApi.
NSObject<FlutterMessageCodec> *WTPPushRegistryDelegateFlutterApiGetCodec(void);

@interface WTPPushRegistryDelegateFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)didUpdatePushTokenForPushTypeVoIP:(nullable NSString *)token completion:(void(^)(NSError *_Nullable))completion;
@end
NS_ASSUME_NONNULL_END
