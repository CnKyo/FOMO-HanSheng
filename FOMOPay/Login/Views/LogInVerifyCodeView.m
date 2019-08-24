//
//  LogInVerifyCodeView.m
//  RazerPay
//
//  Created by apple on 22/01/2019.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "LogInVerifyCodeView.h"

@interface LogInVerifyCodeView()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation LogInVerifyCodeView

+ (LogInVerifyCodeView *)shareView{
    
    LogInVerifyCodeView *view = [[[NSBundle mainBundle] loadNibNamed:@"LogInVerifyCodeView" owner:self options:nil] firstObject];

    __weak typeof(view) weakView = view;
    
    view.mPayView = [WKCustomCodeView shareViewWithType:WKCustomCodeTypeDisplay];
    view.mPayView.mTextBlock = ^(NSString *mText) {
        
        if (mText.length >= 6) {
            
            if ([weakView.delegate respondsToSelector:@selector(WKNewForgetLoginOneTimeOTPviewTextFieldDidEndEditing:)]) {
                
                [weakView.delegate WKNewForgetLoginOneTimeOTPviewTextFieldDidEndEditing:mText];
            }
        }
    };
    [view.mPwdView addSubview:view.mPayView];
    [view.mPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(view.mPwdView).offset(0);
    }];
    
    [view.mReSendBtn addTarget:view action:@selector(mResendAction) forControlEvents:UIControlEventTouchUpInside];
    [view startTimer];
    
    return view;
}
- (void)mResendAction{
    
    if ([self.delegate respondsToSelector:@selector(WKNewForgetLoginOneTimeOTPviewResendOTP)]) {
        
        [self.delegate WKNewForgetLoginOneTimeOTPviewResendOTP];
    }
    
    [self startTimer];
}

- (void)startTimer{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    [_timer fire];
    _time = 0;
}

#pragma mark ---- 停止定时 ----
- (void)stopTimer{
    
    [_timer invalidate];
    _timer = nil;
}

- (void)changeTime{
    
    _time ++;
    NSString *timeString = [NSString stringWithFormat:@"%ld秒后重发",(long)60 - _time];
    [_mReSendBtn setTitle:timeString forState:UIControlStateNormal];
    [_mReSendBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    _mReSendBtn.backgroundColor = [UIColor clearColor];
    _mReSendBtn.enabled = NO;
    if (_time == 60) {
        
        [self stopTimer];
        [_mReSendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [_mReSendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _mReSendBtn.backgroundColor = [UIColor colorWithRed:0 green:90/255.0 blue:182/255.0 alpha:1];
        _mReSendBtn.enabled = YES;
    }
}

- (void)clearPasswordText{
    
    [self.mPayView WKClearText];
}

@end
