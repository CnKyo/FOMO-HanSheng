//
//  WKLoginViewManager.h
//  FOMOPay
//
//  Created by clkj on 2019/9/6.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKLoginViewManager : NSObject
/**
 单例方法
 
 @return 返回对象
 */
+ (instancetype)shareInstance;

/**
 完成登录的回调
 
 @param vc 当前的vc
 @param loginHandle 登录block
 @param forgetHandle 忘记密码block
 */
- (void)WKGotoLoginWithCurrentVC:(UIViewController *)vc didFinishLogin:(void(^)(void))loginHandle didForgetPwd:(void(^)(void))forgetHandle;


/**
 完成登录的回调
 
 @param mobileTextHandel 手机
 @param passwordTextHandel 密码
 @param vc 当前的vc
 @param completion 完成的回调
 */
- (void)WKGotoLoginWithCurrentVCWithMobileTextHandel:(void(^)(NSString *mobile))mobileTextHandel withPasswordTextHandel:(void(^)(NSString *password))passwordTextHandel toViewController:(UIViewController *)vc didFinishLogin:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
