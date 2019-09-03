//
//  CLHistoryCertificateOfRemittance.m
//  FOMOPay
//
//  Created by clkj on 2019/9/3.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryCertificateOfRemittance.h"

@interface CLHistoryCertificateOfRemittance ()

@end

@implementation CLHistoryCertificateOfRemittance

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"汇款证明";
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
    UIView *mView = [UIView new];
    mView.backgroundColor = ssRGBHex(0xF6F5FA);
    [self.view addSubview:mView];
    
    UIWebView *webView = [UIWebView new];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:webView];
    
    UIButton *mButton = [UIButton new];
    [mButton setTitle:@"导出证明图片" forState:UIControlStateNormal];
    mButton.titleLabel.font = kCommonFont(14);
    mButton.backgroundColor = ssRGBHex(0x005CB6);
    [mButton setTitleColor:ssRGBHex(0xffffff) forState:UIControlStateNormal];
    mButton.layer.cornerRadius = 4;
    [mView addSubview:mButton];
    
    
    
    
    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-BottomHeight);
        make.height.offset(76);
        make.width.offset(kScreenWidth);
    }];
    
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(20 + kAppStatusBarHeight +44);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(mView.mas_top);
    }];
    
    
    [mButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mView).mas_offset(22);
        make.left.equalTo(mView).mas_offset(10);
        make.right.equalTo(mView).mas_offset(-10);
        make.bottom.equalTo(mView).mas_offset(-10);
    }];
//    UIWebView *webView = [UIWebView new];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
//    [self.view addSubview:webView];
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(+kAppStatusBarHeight +20 +44);
//        make.left.right.equalTo(self.view);
////        make.bottom.equalTo().offset(-BottomHeight);
//    }];
//    UIView *mView = [UIView new];
//    mView.backgroundColor = [UIColor redColor];
////    ssRGBHex(0xF6F5FA);
//    [self.view addSubview:mView];
//    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-BottomHeight);
//
//    }];
//    UIButton *ExportPDF = [UIButton new];
//    ExportPDF.titleLabel.font = kCommonFont(14);
//    [ExportPDF setTitle:@"导出证明图片" forState:UIControlStateNormal];
//    ExportPDF.layer.cornerRadius = 4;
//    ExportPDF.backgroundColor = ssRGBHex(0x005CB6);
//    ExportPDF.titleLabel.textColor = ssRGBHex(0xffffff);
//    [self.view addSubview:ExportPDF];
//    [ExportPDF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).mas_offset(10);
//        make.right.equalTo(self.view).mas_offset(-10);
//        make.bottom.equalTo(self.view).mas_offset(- BottomHeight - 10 );
//
//    }];
    
    
    
    
    
    
//

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
