//
//  WKAccountManager.h
//  FOMOPay
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    WKLoginStatus_loginSuccess,
    WKLoginStatus_unLogin,
    WKLoginStatus_unknown,
} WKLoginStatus;

@class WKUserInfo;
@interface WKAccountManager : NSObject

@property (strong,nonatomic) NSString *token;

@property (strong,nonatomic) NSString *idNumber;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *idType;
@property (strong,nonatomic) NSString *mobileNumber;

@property (assign,nonatomic) WKLoginStatus loginStatus;

@property (assign,nonatomic) WKAppConfigObj *appConfig;


@property (strong,nonatomic) NSString *mOutCurrenceCode;
@property (strong,nonatomic) NSString *mInCurrenceCode;
@property (strong,nonatomic) NSString *mRate;
@property (strong,nonatomic) NSString *mPushToken;

- (NSString *)token;

- (NSString *)idNumber;
- (NSString *)name;
- (NSString *)idType;
- (NSString *)mobileNumber;


- (NSString *)mOutCurrenceCode;
- (NSString *)mInCurrenceCode;
- (NSString *)mRate;

- (WKLoginStatus)loginStatus;

- (WKAppConfigObj *)appConfig;


- (NSString *)mPushToken;

- (void)WKSetToken:(NSString *)token;

- (void)WKResetUserInfo:(WKUserInfo *)userInfo;

- (void)WKResetAppConfig:(NSString *)appConfig;


- (void)WKResetOutCurrenceCode:(NSString *)mOutCurrenceCode;
- (void)WKResetInCurrenceCode:(NSString *)mInCurrenceCode;
- (void)WKResetRate:(NSString *)mRate;

- (void)WKResetPushToken:(NSString *)mPushToken;

- (void)WKClearnAll;

/**
 单例方法
 
 @return 返回对象本身
 */
+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
