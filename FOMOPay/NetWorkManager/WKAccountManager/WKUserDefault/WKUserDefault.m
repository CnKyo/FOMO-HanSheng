//
//  WKUserDefault.m
//  CLHospitalSysTem
//
//  Created by apple on 2019/6/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKUserDefault.h"
#import "WKEncryption.h"
@implementation WKUserDefault
//目前采样NSUserDefaults存取账号信息
+ (id)objectInUserDefaults:(NSString*)key
{
    NSData * aData = [WKEncryption encrypt:key];
    //NSUTF8StringEncoding 使用之后会获取不到字符串，不知道为啥，所以改变编码方式
    NSString *newKey = [[NSString alloc] initWithData:aData encoding:NSISOLatin1StringEncoding];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:newKey];
}

/**
 将object加密保存
 @param object 要存的对象，已加密或未加密
 @param key 保存的key
 */
+ (void)setObjectInUserDefaults:(id)object withKey:(NSString*)key
{
    NSData * keyData = [WKEncryption encrypt:key];
    //NSUTF8StringEncoding 使用之后会获取不到字符串，不知道为啥，所以改变编码方式
    NSString *newKey = [[NSString alloc] initWithData:keyData encoding:NSISOLatin1StringEncoding];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:object forKey:newKey];
    [ud synchronize];
}
@end
