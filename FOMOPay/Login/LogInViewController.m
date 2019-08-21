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
      
        //发送验证码
        LogInVerifyViewController *vc = [[LogInVerifyViewController alloc] init];
        vc.mobile = content;
        [weakSelf pushToViewController:vc];
    };
    [self.view addSubview:_loginView];
    
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

@end
