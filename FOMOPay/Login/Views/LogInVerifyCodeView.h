//
//  LogInVerifyCodeView.h
//  RazerPay
//
//  Created by apple on 22/01/2019.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WKCustomCodeView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LogInVerifyCodeViewDelegate <NSObject>

@optional

- (void)WKNewForgetLoginOneTimeOTPviewTextFieldDidEndEditing:(NSString *)mText;

- (void)WKNewForgetLoginOneTimeOTPviewResendOTP;

@end


typedef void(^LogInVerifyCodeViewBlock)(NSString *text);

@interface LogInVerifyCodeView : UIView

@property (weak, nonatomic) IBOutlet UILabel *verifyCodeAlertLabel;

@property (weak, nonatomic) IBOutlet UIView *mPwdView;

@property (weak, nonatomic) IBOutlet UIButton *mReSendBtn;

@property (nonatomic, strong) WKCustomCodeView *mPayView;

@property (weak,nonatomic) id <LogInVerifyCodeViewDelegate> delegate;

+ (LogInVerifyCodeView *)shareView;

- (void)clearPasswordText;

- (void)stopTimer;



@end

NS_ASSUME_NONNULL_END
