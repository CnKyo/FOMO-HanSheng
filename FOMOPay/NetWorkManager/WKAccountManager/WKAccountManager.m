//
//  WKAccountManager.m
//  FOMOPay
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKAccountManager.h"
#import "WKUserDefault.h"
#define  kToken                     @"token"
#define  kIdNumber                     @"idNumber"
#define  kName                     @"name"
#define  kIdType                     @"idType"
#define  kMobileNumber                     @"mobileNumber"

#define  kAppConfig                     @"AppConfig"

static WKAccountManager *manager = nil;

@implementation WKAccountManager
/**
 单例方法
 
 @return 返回对象本身
 */
+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        _token = [WKUserDefault objectInUserDefaults:kToken];
        
        _idNumber = [WKUserDefault objectInUserDefaults:kIdNumber];
        _name = [WKUserDefault objectInUserDefaults:kName];
        _idType = [WKUserDefault objectInUserDefaults:kIdType];
        _mobileNumber = [WKUserDefault objectInUserDefaults:kMobileNumber];
        NSDictionary *dic = [CLTool stringToDic:[WKUserDefault objectInUserDefaults:kAppConfig]];
        _appConfig = [WKAppConfigObj yy_modelWithDictionary:dic];
    }
    return self;
}
-(NSString *)token{
    return [WKUserDefault objectInUserDefaults:kToken];
}
- (NSString *)idNumber{
    return [WKUserDefault objectInUserDefaults:kIdNumber];

}
- (NSString *)name{
    return [WKUserDefault objectInUserDefaults:kName];

}
- (NSString *)idType{
    return [WKUserDefault objectInUserDefaults:kIdType];

}
- (NSString *)mobileNumber{
    return [WKUserDefault objectInUserDefaults:kMobileNumber];

}
- (WKLoginStatus)loginStatus{
    if (self.token.length>0) {
        return WKLoginStatus_loginSuccess;
    }else{
        return WKLoginStatus_unLogin;
    }
}
- (WKAppConfigObj *)appConfig{
    NSDictionary *dic = [CLTool stringToDic:[WKUserDefault objectInUserDefaults:kAppConfig]];
    return [WKAppConfigObj yy_modelWithDictionary:dic];
}
- (void)WKResetUserInfo:(WKUserInfo *)userInfo{
    if (userInfo.idNumber.length>0) {
        self.idNumber = userInfo.idNumber;
        [WKUserDefault setObjectInUserDefaults:userInfo.idNumber withKey:kIdNumber];
    }
    if (userInfo.name.length>0) {
        self.name = userInfo.name;
        [WKUserDefault setObjectInUserDefaults:userInfo.name withKey:kName];
    }
    if (userInfo.idType.length>0) {
        self.idType = userInfo.idType;
        [WKUserDefault setObjectInUserDefaults:userInfo.idType withKey:kIdType];
    }
    if (userInfo.mobileNumber.length>0) {
        self.mobileNumber = userInfo.mobileNumber;
        [WKUserDefault setObjectInUserDefaults:userInfo.mobileNumber withKey:kMobileNumber];
    }
}
- (void)WKResetAppConfig:(NSString *)appConfig{

    self.appConfig = [WKAppConfigObj yy_modelWithDictionary:[CLTool stringToDic:appConfig]];
    [WKUserDefault setObjectInUserDefaults:appConfig withKey:kAppConfig];

}
- (void)WKSetToken:(NSString *)token{
    self.token = token;
    [WKUserDefault setObjectInUserDefaults:token withKey:kToken];
}
- (void)WKClearnAll{
    [self WKSetToken:@""];
    [self WKResetAppConfig:@""];
}
@end
