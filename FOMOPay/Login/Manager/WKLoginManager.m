//
//  WKLoginManager.m
//  FOMOPay
//
//  Created by clkj on 2019/9/5.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKLoginManager.h"
#import "LogInViewController.h"
#import "LogInVerifyViewController.h"
#import <WKWindowManagerFramework/WKWindowManagerFramework.h>
static WKLoginManager *mManager = nil;

@interface WKLoginManager ()
@property (strong,nonatomic) WKWindowManager *mWindow;
//@property (strong,nonatomic)
@property (strong,nonatomic) LogInViewController *mRootLoginVC;

@property (strong,nonatomic) LogInVerifyViewController *mLoginVC;

@end

@implementation WKLoginManager

+ (instancetype)shareInstance{
    if(!mManager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            mManager = [[WKLoginManager alloc]init];
        });
    }
    return mManager;
}

-(id)init{
    self = [super init];
    if(self){
        self.mWindow = [WKWindowManager sharedWindowManager];
    }
    return self;
}

-(void)presentLoginViewController:(void (^)(void))completion{
    WS(weakSelf);
    if(!self.mWindow){
        self.mWindow = [WKWindowManager sharedWindowManager];
    }
    self.mRootLoginVC  = [LogInViewController new];
    UINavigationController *mNav = [[UINavigationController alloc]initWithRootViewController:self.mRootLoginVC];

    
    UIWindow *window  = [WKWindowManager templateWindowForName:@"vc"];
    window.rootViewController = mNav;
   [self.mWindow.topWindow presentWindow:window animated:YES completion:nil];
}

@end


