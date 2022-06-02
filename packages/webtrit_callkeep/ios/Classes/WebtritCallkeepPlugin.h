#import <Flutter/Flutter.h>

@interface WebtritCallkeepPlugin : NSObject<FlutterPlugin>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
- (BOOL)isSetUp;
@end
