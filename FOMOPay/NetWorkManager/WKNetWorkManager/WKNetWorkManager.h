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
+ (void)WKGetLoginOtp:(NSDictionary *)para block:(void(^)(NSString *result,BOOL success))block;

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
#pragma mark----****----退出登录
/**
 退出登录

 @param block 返回值
 */
+ (void)WKLogOut:(void(^)(id result,BOOL success))block;
#pragma mark----****----获取app的配置信息
/**
 获取app的配置信息

 @param block 返回值
 */
+ (void)WKGetAppConfig:(void(^)(id result,BOOL success))block;
#pragma mark----****----获取汇款列表
/**
 获取汇款列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKGetRemiitablePara:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;

#pragma mark----****----添加退款账号
/**
 添加退款账号

 @param para 参数
 @param block 返回值
 */
+ (void)WKAddRefundAccount:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;
#pragma mark----****----获取退款账户
/**
 获取退款账户

 @param para 参数
 @param block 返回值
 */
+ (void)WKGetRefundAccount:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;
#pragma mark----****---- 创建收款人信息
/**
 创建收款人信息

 @param para 参数
 @param block 返回值
 */
+ (void)WKCreateRecipientAcc:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;

#pragma mark----****----获取票据信息
/**
 获取票据信息

 @param block 返回值
 */
+ (void)WKGetRecipient:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;
#pragma mark----****----获取收款人详情
/**
 获取收款人详情

 @param para 参数
 @param block 返回值
 */
+ (void)WKGetRecipientDetail:(NSString *)para block:(void(^)(id result,BOOL success))block;
#pragma mark----****----开始汇款
/**
 开始汇款

 @param para 参数
 @param block 返回值
 */
+ (void)WKRemiitanceNow:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;
#pragma mark----****----删除收款人
/**
 删除收款人

 @param para 参数
 @param block 返回值
 */
+ (void)WKDeleteRecipient:(NSString *)para block:(void(^)(id result,BOOL success))block;



#pragma  mark----****----查询订单列表
/**
 查询订单列表

 @param para 参数
 @param block 返回值
 */
+ (void)WKGetOrderList:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;
#pragma  mark----****----获取订单详情
/**
 获取订单详情

 @param para 参数
 @param block 返回值
 */
+ (void)WKGetOrderDetail:(NSString *)para block:(void(^)(id result,BOOL success))block;

#pragma mark----****----修改收款人信息
/**
 修改收款人信息

 @param recipientId 收款人ID
 @param para 参数
 @param block 返回值
 */
+ (void)WKModifyRecipientInfo:(NSString *)recipientId andPara:(NSDictionary *)para block:(void(^)(id result,BOOL success))block;
#pragma mark----****----删除收款人信息
/**
 删除收款人信息

 @param recipientId 收款人ID
 @param block 返回值
 */
+ (void)WKDeleteRecipientInfo:(NSString *)recipientId block:(void(^)(id result,BOOL success))block;
#pragma mark----****----删除订单
/**
 删除订单

 @param orderId 订单ID
 @param block 返回值
 */
+ (void)WKDeleteOrder:(NSString *)orderId block:(void(^)(id result,BOOL success))block;

@end

