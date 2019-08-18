//
//  CLMeMessageViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/16.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeMessageViewController.h"

@interface CLMeMessageViewController ()

@end

@implementation CLMeMessageViewController

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
    UIImageView *MessageView = [UIImageView new];
    MessageView.image= [UIImage yh_imageNamed:@"pdf_me_message_logo.pdf"];
    [self.view addSubview:MessageView];
    UIButton *NoOpenMessage = [[UIButton alloc]init];
    UIButton *OpenMessage = [[UIButton alloc]init];
    NoOpenMessage.backgroundColor = ssRGBHex(0xF6F5FA);
    OpenMessage.backgroundColor = ssRGBHex(0x005CB6);
   NoOpenMessage.layer.borderColor = ssRGBHex(0x005CB6).CGColor;
    NoOpenMessage.layer.borderWidth = 1;
    NoOpenMessage.layer.cornerRadius = 5;
     OpenMessage.layer.cornerRadius = 5;
    [NoOpenMessage setTitle:@"不打开" forState:UIControlStateNormal];
     [OpenMessage setTitle:@"打开" forState:UIControlStateNormal];
    [NoOpenMessage setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    [self.view addSubview:OpenMessage];
    [self.view addSubview:NoOpenMessage];
    [MessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(162);
        make.left.equalTo(self.view).offset(86);
        make.right.equalTo(self.view).offset(-87);
    }];
    [NoOpenMessage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(200);
      
        make.bottom.equalTo(self.view).offset(-44 );
        make.left.equalTo(self.view).offset(4);
        make.width.offset(181);
        make.height.offset(42);
      
    }];
    [OpenMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-44);
        make.right.equalTo(self.view).offset(-4);
        make.width.offset(181);
        make.height.offset(42);
    }];
}
    // Do any additional setup after loading the view.


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
