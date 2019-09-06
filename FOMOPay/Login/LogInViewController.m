//
//  LogInViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "LogInViewController.h"

#import "DPLogInView.h"
#import "LogInVerifyViewController.h"

@interface LogInViewController ()

@property (nonatomic, strong) DPLogInView *loginView;


@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;

    _loginView = [DPLogInView shareView];
    _loginView.backgroundColor = [UIColor whiteColor];
    _loginView.LogInViewBlock = ^(NSString * _Nonnull content) {
      
        
        [weakSelf getOtp:content];
    };
    [self.view addSubview:_loginView];
    
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.right.bottom.equalTo(self.view);
    }];
}
- (void)getOtp:(NSString *)text{
    
    [self showLoading:nil];
    [WKNetWorkManager WKGetLoginOtp:@{@"ic":text} block:^(NSString *result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            NSDictionary *dic = [CLTool stringToDic:result];
            [[WKAccountManager shareInstance] WKResetUserInfo:[WKUserInfo yy_modelWithDictionary:dic]];
            LogInVerifyViewController *vc = [[LogInVerifyViewController alloc] init];
            vc.mobile = text;
            [self pushToViewController:vc];
        }else{
            TOASTMESSAGE(result);
        }
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end
