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

///**
// 获取启动页
//
// @param block 返回值
// */
//+ (void)WKGetLaunchImage:(void(^)(WKBaseModel *info,WKLaunchAdInfo *adInfo))block;
//
///**
// 登录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKLogin:(NSDictionary *)para block:(void(^)(WKBaseModel *info,WKUserInfo *userInfo))block;
//
///**
// 获取用户信息
//
// @param block 返回值
// */
//+ (void)WKGetUserInfo:(void(^)(WKBaseModel *info,WKUserInfo *userInfo))block;
//
///**
// 获取验证码
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetOtp:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSString *otp))block;
//
///**
// 修改登录密码
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKChangePWD:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
///**
// 获取随访列表
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetFollowList:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 获取未读消息数
//
// @param block 返回值
// */
//+ (void)WKGetUnreadNum:(void(^)(WKBaseModel *info,WKUnreadObj *count))block;
//
///**
// 阅读消息
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKReadMessage:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 获取随访详情
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetFollowDetailg:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 获取通知列表
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetNotifyList:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 获取通知详情
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetNotifyDetail:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 修改昵称和手机号
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKChangeNickNameOrMobile:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 获取患者详情信息
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetPatientDetailInfo:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 获取电话随访记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetMobileFollwRecord:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 修改电话随访记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKModifyPhoneFollowRecords:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 新增电话回访记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKAddPhoneFollowRecords:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 获取筛选分类模版
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetFilterTemplete:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
//
///**
// 获取患者分类
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetPatientCategory:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 查询拨号l记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetCallRecordList:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 获取回访周期设置
//
// @param block 返回值
// */
//+ (void)WKGetFollowSeting:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 保存回访周期设置
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKSaveFollowSetting:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 获取帮助中心
//
// @param block 返回值
// */
//+ (void)WKGetHelpCenter:(void(^)(WKBaseModel *info))block;
//
///**
// 版本更新
//
// @param block 返回值
// */
//+ (void)WKUpdateVersion:(void(^)(WKBaseModel *info))block;
//
///**
// 搜索
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKSearchInfo:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
//
///**
// 删除患者
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKDeletePatient:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 获取添加患者模版
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetAddPatientStyle:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block;
//
///**
// 添加患者信息
// @param para 参数
// @param block 返回值
// */
//+ (void)WKAddPatientInfo:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;
//
///**
// 获取推送通知开关状态
//
// @param block 返回值
// */
//+ (void)WKGetPushSwitchStatus:(void(^)(WKBaseModel *info))block;
//
///**
// 修改推送通知开关状态
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKSavePushSwitchStatus:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block;

@end

