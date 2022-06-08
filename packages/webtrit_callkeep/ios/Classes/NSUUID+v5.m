#import "NSUUID+v5.h"

#import <CommonCrypto/CommonCrypto.h>

NSString *const NAMESPACE_DNS = @"6ba7b810-9dad-11d1-80b4-00c04fd430c8";
NSString *const NAMESPACE_URL = @"6ba7b811-9dad-11d1-80b4-00c04fd430c8";
NSString *const NAMESPACE_OID = @"6ba7b812-9dad-11d1-80b4-00c04fd430c8";
NSString *const NAMESPACE_X500 = @"6ba7b814-9dad-11d1-80b4-00c04fd430c8";
NSString *const NAMESPACE_NIL = @"00000000-0000-0000-0000-000000000000";

@implementation NSUUID (NSUUIDv5)
+ (instancetype)makeWithName:(NSString *)name namespace:(NSUUID *)ns {
  NSData *nameData = [name dataUsingEncoding:NSUTF8StringEncoding];

  uuid_t namespaceUuid;
  [ns getUUIDBytes:namespaceUuid];

  unsigned char md[CC_SHA1_DIGEST_LENGTH];
  CC_SHA1_CTX c;
  CC_SHA1_Init(&c);
  CC_SHA1_Update(&c, namespaceUuid, sizeof(namespaceUuid));
  CC_SHA1_Update(&c, nameData.bytes, (CC_LONG) nameData.length);
  CC_SHA1_Final(md, &c);

  // set UUID version to 5
  md[6] = (unsigned char) ((md[6] & 0x0F) | 0x50);

  // set variant accordingly to RFC4122 (reserved)
  md[8] = (unsigned char) ((md[8] & 0x3F) | 0x80);

  return [[NSUUID alloc] initWithUUIDBytes:md];
}
@end
