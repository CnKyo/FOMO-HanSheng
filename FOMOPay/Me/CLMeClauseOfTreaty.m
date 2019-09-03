//
//  CLMeClauseOfTreaty.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeClauseOfTreaty.h"

@interface CLMeClauseOfTreaty ()<UIScrollViewDelegate>

@end

@implementation CLMeClauseOfTreaty

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"条约条款";
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
    UIWebView *webView = [UIWebView new];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[WKAccountManager shareInstance].appConfig.tncLink]]];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(+kAppStatusBarHeight +8 +44);
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.bottom.equalTo(self.view).offset(-BottomHeight);
    }];
}
     
     
     

@end
