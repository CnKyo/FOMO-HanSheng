//
//  CLHistoryAuthentication.m
//  FOMOPay
//
//  Created by Lever on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryAuthentication.h"
#import "LogInVerifyCodeView.h"
@interface CLHistoryAuthentication ()<LogInVerifyCodeViewDelegate>
@property (nonatomic, strong) LogInVerifyCodeView *verifyCodeView;
@property (nonatomic, copy) NSString *mCodeStr;
@end

@implementation CLHistoryAuthentication

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份验证";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    
    _verifyCodeView = [LogInVerifyCodeView shareView];
    _verifyCodeView.delegate = self;
    _verifyCodeView.verifyCodeAlertLabel.text = [NSString stringWithFormat:@"请输入发送到****%@的6位验证码",[_mobile substringFromIndex:_mobile.length - 4]];
    [self.view addSubview:_verifyCodeView];
    
    [_verifyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(46 + kAppStatusBarHeight);
    }];
    
    [_verifyCodeView.mPayView WKShowKeyborad];
}


- (void)mResendAction{
    [self showLoading:nil];
    [WKNetWorkManager WKGetLoginOtp:@{@"ic":self.mobile} block:^(NSString *result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            NSDictionary *dic = [CLTool stringToDic:result];
            [[WKAccountManager shareInstance] WKResetUserInfo:[WKUserInfo yy_modelWithDictionary:dic]];
            TOASTMESSAGE(@"验证码发送成功!");
        }else{
            TOASTMESSAGE(result);
        }
    }];
}

- (void)verifyCode:(NSString *)code{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
//    [para setObject:self.mobile forKey:@"ic"];
//    [para setObject:code forKey:@"otp"];
    [self showLoading:@""];
    [WKNetWorkManager WKGetToken:para block:^(NSString *token, BOOL success) {
        [self hiddenLoading];
        if (success) {
            DebugLog(@"得到的Token是:%@",token);
            [[WKAccountManager shareInstance] WKSetToken:token];
            
           
            
        }else{
            DebugLog(@"错误信息:%@",token);
            TOASTMESSAGE(token);
        }
    }];
    
    
    
}


- (void)WKNewForgetLoginOneTimeOTPviewTextFieldDidEndEditing:(NSString *)mText{
    
    [self verifyCode:mText];
}

- (void)WKNewForgetLoginOneTimeOTPviewResendOTP{
    
    //重新发送验证码
    [self mResendAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
