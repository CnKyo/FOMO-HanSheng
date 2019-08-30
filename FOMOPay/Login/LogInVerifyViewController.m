//
//  LogInVerifyViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "LogInVerifyViewController.h"

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

- (void)verifyCode:(NSString *)code{
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mobile forKey:@"ic"];
    [para setObject:code forKey:@"otp"];
    [WKNetWorkManager WKGetToken:para block:^(NSString *token, BOOL success) {
        if (success) {
            DebugLog(@"得到的Token是:%@",token);
            [[WKAccountManager shareInstance] WKSetToken:token];
            
            [self goLogin];
            
        }else{
            DebugLog(@"错误信息:%@",token);
        }
    }];
    
}

- (void)goLogin{
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mobile forKey:@"ic"];
    [WKNetWorkManager WKLogin:para block:^(NSDictionary *result, BOOL success) {
        if (success) {
            
            WKUserInfo *mUser  = [WKUserInfo yy_modelWithDictionary:result];
            [[WKAccountManager shareInstance] WKResetUserInfo:mUser];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLogInKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            CLMainTabBarControllerConfig *tabbarConfig = [CLMainTabBarControllerConfig new];
            [appdelegate.window setRootViewController:tabbarConfig.tabBarController];
        }else{
            
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
