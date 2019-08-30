//
//  WKProgressHudManager.h
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKProgressHudManager : NSObject

+ (instancetype)shareInstance;

- (void)showLoadingWithText:(NSString *)text withView:(UIView *)view;

- (void)showSuceessWithText:(NSString *)text withView:(UIView *)view;

- (void)showErrorWithText:(NSString *)text withView:(UIView *)view;

- (void)showPromptWithText:(NSString *)text withView:(UIView *)view;

- (void)hiddenHud;
@end

NS_ASSUME_NONNULL_END
