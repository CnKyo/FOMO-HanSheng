//
//  LogInVerifyViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "LogInVerifyViewController.h"
#import "WKLoginViewManager.h"
#import "LogInVerifyCodeView.h"
#import "AppDelegate.h"

@interface LogInVerifyViewController ()<LogInVerifyCodeViewDelegate>

@property (nonatomic, strong) LogInVerifyCodeView *verifyCodeView;
@property (nonatomic, copy) NSString *mCodeStr;

@end

@implementation LogInVerifyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"身份验证";
    self.title = languageStr(@"authentication");
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    
    _verifyCodeView = [LogInVerifyCodeView shareView];
    _verifyCodeView.delegate = self;
    _verifyCodeView.verifyCodeAlertLabel.text = [NSString stringWithFormat:@"%@****%@%@6%@",languageStr(@"Please send"),[_mobile substringFromIndex:_mobile.length - 4],languageStr(@"Of"),languageStr(@"Verification Code")];
//    _verifyCodeView.verifyCodeAlertLabel.text = [NSString stringWithFormat:@"请输入发送到****%@的6位验证码",languageStr(@""),[_mobile substringFromIndex:_mobile.length - 4]];
    [self.view addSubview:_verifyCodeView];
    
    [_verifyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(46 + kAppStatusBarHeight);
    }];
    
    [_verifyCodeView.mPayView WKShowKeyborad];
}

- (void)mBackAction{
    
    __block typeof(self) blockSelf = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要返回吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addAction:okAction];
    
    [alertController addAction:backAction];
    
    [blockSelf presentViewController:alertController animated:YES completion:nil];
    
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
    WS(weakSelf);
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mobile forKey:@"ic"];
    [para setObject:code forKey:@"otp"];
    [self showLoading:@""];
    [WKNetWorkManager WKGetToken:para block:^(NSString *token, BOOL success) {
        [self hiddenLoading];
        if (success) {
            DebugLog(@"得到的Token是:%@",token);
            [[WKAccountManager shareInstance] WKSetToken:token];
//            [[WKLoginViewManager shareInstance]WKGotoLoginWithCurrentVC:self          didFinishLogin:^{
////
//                } didForgetPwd:^{
////
//            }];
            [self goLogin];

        }else{
            DebugLog(@"错误信息:%@",token);
            TOASTMESSAGE(token);
        }
    }];
    

    
}

- (void)goLogin{
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLogInKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.verifyCodeView removeFromSuperview];
//    self.view.hidden = YES;
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CLMainTabBarControllerConfig *tabbarConfig = [CLMainTabBarControllerConfig new];
    [appdelegate.window setRootViewController:tabbarConfig.tabBarController];
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
