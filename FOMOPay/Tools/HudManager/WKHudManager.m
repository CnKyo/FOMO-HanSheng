//
//  WKHudManager.m
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKHudManager.h"

#import "WKProgressHudManager.h"

@implementation WKHudManager

+ (void)WKShowLoadingHud:(NSString *)message view:(UIView *)view{
    
    if (message.length <= 0) {
        
        message = @"加载中...";
    }
   
    [[WKProgressHudManager shareInstance] showLoadingWithText:message withView:view];
}

+ (void)WKShowErrorHud:(NSString *)message view:(UIView *)view{
    
    [[WKProgressHudManager shareInstance] showErrorWithText:message withView:view];
}

+ (void)WKShowSuccessHud:(NSString *)message view:(UIView *)view{
    
    [[WKProgressHudManager shareInstance] showSuceessWithText:message withView:view];
}

+ (void)WKShowAlertHud:(NSString *)message{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showInfoWithStatus:message];
}

+ (void)WKHiddenHud{
    
    [[WKProgressHudManager shareInstance] hiddenHud];
}


@end
