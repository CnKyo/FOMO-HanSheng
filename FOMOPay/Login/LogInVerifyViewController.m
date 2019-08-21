//
//  LogInVerifyViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "LogInVerifyViewController.h"

#import "LogInVerifyCodeView.h"

@interface LogInVerifyViewController ()

@property (nonatomic, strong) LogInVerifyCodeView *verifyCodeView;
@property (nonatomic, copy) NSString *mCodeStr;

@end

@implementation LogInVerifyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"身份验证";
    
    __weak typeof(self) weakSelf = self;
    _verifyCodeView = [LogInVerifyCodeView shareView];
    _verifyCodeView.verifyCodeAlertLabel.text = [NSString stringWithFormat:@"请输入发送到****%@的6位验证码",[_mobile substringFromIndex:_mobile.length - 4]];
    [_verifyCodeView.mReSendBtn addTarget:self action:@selector(mResendAction) forControlEvents:UIControlEventTouchUpInside];
    
    _verifyCodeView.mTextBlock = ^(NSString *mText) {
        
        NSLog(@"you are inpput %@",mText);
        if (mText.length >= 6) {
            
            weakSelf.mCodeStr = mText;
            [weakSelf verifyCode];
        }
    };
    
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
    
//    NSDictionary *params = @{
//                             @"mobile":_mMobileString,
//                             @"type":@"signUp",
//                             };
//    [self showLoadingView];
//    __block typeof(self) blockSelf = self;
//    [SendOtp requestWithParameters:params andResultBlock:^(id response, NSError *error) {
//        SendOtp *entity = [[SendOtp alloc] initWithResponse:response andError:error];
//        DebugLog(@"entity.errorEntity.messag : %@",entity.errorEntity.message);
//        if (entity.isSuccessed) {
//
//
//            //            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"There could be a delay. Please wait in patience. " preferredStyle:UIAlertControllerStyleAlert];
//            //            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//            //            UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleCancel handler:nil];
//            //
//            //            [alertController addAction:okAction];
//            //
//            //            [alertController addAction:backAction];
//            //            [blockSelf presentViewController:alertController animated:YES completion:nil];
//
//            self.mView.mResendBtn.hidden = YES;
//            self.mView.mCountTimeLb.hidden = NO;
//
//            __weak typeof(self) weakSelf = self;
//
//            [weakSelf.mView.mCountTimeLb setupText:@"You will receive the one-time password within " andEndText:@"seconds" andTime:[NSDate dateWithTimeIntervalSinceNow:60]];
//            weakSelf.mView.mCountTimeLb.mStopBlock = ^{
//                weakSelf.mView.mResendBtn.hidden = NO;
//                weakSelf.mView.mCountTimeLb.hidden = YES;
//            };
//        }else{
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:entity.errorEntity.message preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//            [alertController addAction:okAction];
//            [blockSelf presentViewController:alertController animated:YES completion:nil];
//        }
//        [blockSelf hidenLoadingView];
//    }];
}


- (void)verifyCode{
    //
//    NSDictionary *parama = @{
//                             @"mobile":self.mMobileString,
//                             @"type":@"signUp",
//                             @"otp":[NSString nonNullCheck:self.mCodeStr],
//                             @"publicKey":[PublicConfig shareUtility].publickKey,
//                             };
//    __weak typeof(self) weakSelf = self;
//
//
//    [self showWKHud:@"Security check in progress..."];
//
//    [VerifyOTP requestWithParameters:parama andResultBlock:^(id response, NSError *error) {
//
//        [weakSelf dissmissWKHud];
//        VerifyOTP *entity = [[VerifyOTP alloc] initWithDictionary:response];
//        if (entity.isSuccessed) {
//            [[AccountManager defaultManager]resetSignUpSecurityToken:entity.securityToken];
//
//            DebugLog(@"----securityToken：%@",[AccountManager defaultManager].securityToken);
//            if  ([[WKCurrenceManager shareInstance].mCountryCode isEqualToString:kAppSingaporCurrencyCode]){
//                SPSignUpTVViewController *vc=[[SPSignUpTVViewController alloc] initWithNibName:@"SPSignUpTVViewController" bundle:nil];
//                vc.mEmailString=self.mEmailString;
//                vc.mIsReceiving=self.mIsReceiving;
//                [self pushViewConteoller:vc];
//            }
//            else{
//                WKNewSignUpTViewController *vc = [WKNewSignUpTViewController new];
//                vc.mEmailString=self.mEmailString;
//                vc.mIsReceiving=self.mIsReceiving;
//                [self pushViewConteoller:vc];
//                //            WKEnterPwdViewController *vc = [WKEnterPwdViewController new];
//                //            vc.mobileString = self.mMobileString;
//                //            vc.mSignInfo = self.mSignInfo;
//                //            vc.navigationItem.title = self.navigationItem.title;
//                //            vc.isForgot = 0;
//                //            vc.isSignup = 1;
//                //            vc.mType = WKSignUpType;
//                //            [self.navigationController pushViewController:vc animated:YES];
//            }
//
//        }else{
//
//            [SVStatusHUD showWithImage:[UIImage yh_imageNamed:@"pdf_info_hud"] status:@"Incorrect OTP entered,\nplease retry."];
//        }
//        [self.mView WKClearText];
//    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
