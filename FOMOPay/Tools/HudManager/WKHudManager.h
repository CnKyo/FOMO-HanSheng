//
//  WKHudManager.h
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKHudManager : NSObject

+ (void)WKShowLoadingHud:(NSString *)message view:(UIView *)view;

+ (void)WKShowErrorHud:(NSString *)message view:(UIView *)view;

+ (void)WKShowSuccessHud:(NSString *)message view:(UIView *)view;

+ (void)WKShowAlertHud:(NSString *)message;

+ (void)WKHiddenHud;
@end

