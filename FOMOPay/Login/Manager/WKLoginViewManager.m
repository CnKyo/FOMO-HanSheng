//
//  WKLoginViewManager.m
//  FOMOPay
//
//  Created by clkj on 2019/9/6.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKLoginViewManager.h"
#import "DPLoginView.h"
#import "LogInVerifyViewController.h"
#import "AppDelegate.h"
static WKLoginViewManager *mManager = nil;
@interface WKLoginViewManager()

@property (strong,nonatomic)DPLogInView *mLoginView;
@property (strong,nonatomic) NSString *mAccount;

@property (strong,nonatomic) NSString *mPwd;


@end
@implementation WKLoginViewManager
/**
 单例方法
 
 @return 返回对象
 */
+ (instancetype)shareInstance{
    if (!mManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            mManager = [[WKLoginViewManager alloc] init];
        });
    }
    return mManager;
}
- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/**
 完成登录的回调
 
 @param vc 当前的vc
 @param loginHandle 登录block
 @param forgetHandle 忘记密码block
 */
-(void)WKGotoLoginWithCurrentVC:(UIViewController *)vc didFinishLogin:(void (^)(void))loginHandle didForgetPwd:(void (^)(void))forgetHandle{
    WS(weakSelf);
//    self.mLoginView  = [DPLogInView shareView];
//    [vc.view addSubview:self.mLoginView];
    [self goLogin];
//    [self.mLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(vc.view).offset(0);
//        make.top.equalTo(vc.view).offset(44+kAppStatusBarHeight);
//        make.bottom.equalTo(vc.view).offset(BottomHeight);
//    }];
//
}

/**
 完成登录的回调
 
 @param mobileTextHandel 手机
 @param passwordTextHandel 密码
 @param vc 当前的vc
 @param completion 完成的回调
 */
- (void)WKGotoLoginWithCurrentVCWithMobileTextHandel:(void (^)(NSString * _Nonnull))mobileTextHandel withPasswordTextHandel:(void (^)(NSString * _Nonnull))passwordTextHandel toViewController:(UIViewController *)vc didFinishLogin:(void (^)(void))completion{
   
    
};




    
- (void)gotoLogin:(UIViewController *)vc didFinishLogin:(void(^)(void))completion{
    
    if (completion) {
        completion();
    }
}

- (void)goLogin{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CLMainTabBarControllerConfig *tabbarConfig = [CLMainTabBarControllerConfig new];
    [appdelegate.window setRootViewController:tabbarConfig.tabBarController];
}

@end
