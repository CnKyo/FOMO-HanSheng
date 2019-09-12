//
//  CommonGuideViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CommonGuideViewController.h"
#import "CommonGuideView.h"
#import "LogInViewController.h"

@interface CommonGuideViewController ()

@property (nonatomic, strong) CommonGuideView *guideView;

@end

@implementation CommonGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _guideView = [[CommonGuideView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) superVC:self];
    _guideView.finishAction = @selector(finishGuideView);
    [self.view addSubview:_guideView];
}

- (void)finishGuideView{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoadGuideKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    LogInViewController *VC = [[LogInViewController alloc] init];
    [self pushToViewController:VC];
}



@end
