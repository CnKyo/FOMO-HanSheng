//
//  CLMeMessageSetViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeMessageSetViewController.h"
#import "WKMessageNotifycationView.h"

@interface CLMeMessageSetViewController ()

@property (strong,nonatomic) WKMessageNotifycationView *mView;

@end

@implementation CLMeMessageSetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        switch (tag) {
            case 0:
            {
                DebugLog(@"左边按钮");
            }
                break;
            case 1:
            {
                DebugLog(@"右边按钮");
            }
                break;
            default:
                break;
        }
    }];
    [self initView];
}
- (void)initView{
    self.mView = [WKMessageNotifycationView shareView];
    if (![CLTool WKIsUserOpenNotificationEnable]) {
        self.mView.mSwitch.on = NO;
    }else{
        self.mView.mSwitch.on = YES;
    }
    self.mView.mBlock = ^(BOOL On) {
        if (On) {
            [CLTool WKGoToOpenAppSystemSetting];
        }else{
            [CLTool WKGoToOpenAppSystemSetting];
        }
    };
    [self.view addSubview:self.mView];
    [self.mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(44+kAppStatusBarHeight);
        make.bottom.equalTo(self.view).offset(-kBottomToolBarHeight);
    }];
}
@end
