//
//  WKNetWorkManager.h
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <PPNetworkHelper/PPNetworkHelper.h>
//#import "WKAccessObj.h"

@interface WKNetWorkManager : NSObject
#pragma mark----****----获取版本信息
/**
 获取版本信息

 @param para 参数
 @param block 返回值
 */
+ (void)WKGetAppVersion:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
#pragma mark----****----获取登录otp
/**
 获取登录otp

 @param para 参数
 @param block 返回值
 */
+ (void)WKGetLoginOtp:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;

#pragma mark----****----获取Token
/**
 获取Token

 @param para 参数
 @param block 返回值
 */
+(void)WKGetToken:(NSDictionary *)para block:(void(^)(NSString *token,BOOL success))block;

#pragma mark----****----登录
/**
 登录

 @param para 参数
 @param block 返回值
 */
+ (void)WKLogin:(NSDictionary *)para block:(void(^)(NSDictionary *result,BOOL success))block;
@end

