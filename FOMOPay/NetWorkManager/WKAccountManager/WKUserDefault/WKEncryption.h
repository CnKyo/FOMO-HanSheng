//
//  WKEncryption.h
//  CLHospitalSysTem
//
//  Created by apple on 2019/6/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKEncryption : NSObject
+ (NSData*)encrypt:(NSString*)encryptionString;

+ (NSString*)decrypt:(NSData*)decryptionData;
@end
@interface NSData (Encryption)

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密

- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密

- (NSString *)newStringInBase64FromData;            //追加64编码

+ (NSString*)base64encode:(NSString*)str;           //同上64编码
@end

NS_ASSUME_NONNULL_END
