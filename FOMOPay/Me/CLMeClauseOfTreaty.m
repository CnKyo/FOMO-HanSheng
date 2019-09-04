//
//  CLMeClauseOfTreaty.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeClauseOfTreaty.h"

@interface CLMeClauseOfTreaty ()<UIScrollViewDelegate,UIWebViewDelegate>

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
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(+kAppStatusBarHeight +8 +44);
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.bottom.equalTo(self.view).offset(-BottomHeight);
    }];
}
     
#pragma mark - delegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    DebugLog(@"开始加载网页");
    [self showLoading:nil];
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    DebugLog(@"加载完成");
    [self hiddenLoading];
}

//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    DebugLog(@"加载失败");
    [self hiddenLoading];
    TOASTMESSAGE(error.description);
    
}



@end
