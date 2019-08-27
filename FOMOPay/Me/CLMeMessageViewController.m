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
    
    UILabel *OpenLabel = [UILabel new];
    
    OpenLabel.text = @"打开消息通知";
    
    [OpenLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:18]];
    
    UILabel *OpenLabelHint = [UILabel new];
    
    OpenLabelHint.text = @"打开汇款实时通知,可以更快了解您的汇款状态";
    
    [OpenLabelHint setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    
    [OpenLabelHint setTextColor:ssRGBHex(0x8C9091)];
    
    [self.view addSubview:OpenLabel];
    
    [self.view addSubview:OpenLabelHint];
    
    UIButton *NoOpenMessage = [[UIButton alloc]init];
    
    UIButton *OpenMessage = [[UIButton alloc]init];
    [NoOpenMessage addTarget:self action:@selector(PushSetMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    [OpenMessage addTarget:self action:@selector(PushSetMessage:) forControlEvents:UIControlEventTouchUpInside];
    
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
        make.height.offset(151);
        make.width.offset(204);
        make.centerX.equalTo(OpenLabel);
        make.bottom.equalTo(OpenLabel.mas_top).offset(-21);

    }];
    
    [OpenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.offset(18);
    }];
    
    [OpenLabelHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(OpenLabel);
        make.top.equalTo(OpenLabel.mas_bottom).offset(15);
        make.height.offset(14);
    }];

    
    
    [NoOpenMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 4  );
        make.left.equalTo(self.view).offset(4);
        make.width.offset(181);
        make.height.offset(42);
      
    }];
    [OpenMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 4 );
        make.right.equalTo(self.view).offset(-4);
        make.width.offset(181);
        make.height.offset(42);
    }];
}

-(void)PushSetMessage:(id)sender{
    CLMeMessageSetViewController *vc = [CLMeMessageSetViewController new];
    [self pushToViewController:vc];
}
@end
