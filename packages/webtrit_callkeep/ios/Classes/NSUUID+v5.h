#import <Foundation/Foundation.h>

extern NSString *const NAMESPACE_DNS;
extern NSString *const NAMESPACE_URL;
extern NSString *const NAMESPACE_OID;
extern NSString *const NAMESPACE_X500;
extern NSString *const NAMESPACE_NIL;

@interface NSUUID (NSUUIDv5)
+ (instancetype)makeWithName:(NSString *)name namespace:(NSUUID *)ns;
@end
