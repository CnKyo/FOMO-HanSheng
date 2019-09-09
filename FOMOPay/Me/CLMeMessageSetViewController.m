//
//  CLMeMessageSetViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeMessageSetViewController.h"

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
    [self LoadCellType:11];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeLanguage_other *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLMeLanguage_other alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mMeLanguageLeftLabel.text = @"消息权限";
    cell.mMeLanguageLeftLabel.textColor = ssRGBHex(0x2B2B2B);
    self.MessageSwitch = [UISwitch new];
    self.MessageSwitch.onTintColor =ssRGBHexAlpha(0x005CB6, 0.2);
    self.MessageSwitch.thumbTintColor =ssRGBHex(0x005CB6);
    self.MessageSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [cell.contentView addSubview:self.MessageSwitch];
    [self.MessageSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.MessageSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell).offset(-31);
//        make.height.offset(12.46);
//        make.width.offset(30.26);
//        make.top.equalTo(cell).offset(15);
//        make.bottom.equalTo(cell).offset(-15);
        make.centerY.equalTo(cell.mMeLanguageLeftLabel);
            }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *mHeadView = [UIView new];
    mHeadView.backgroundColor = ssRGBHex(0xF6F5FA);
    return mHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *mFootView = [UIView new];
    mFootView.backgroundColor =ssRGBHex(0xF6F5FA);
//    mFootView.backgroundColor = [UIColor redColor];
   self.mFootViewLable = [UILabel new];
    self.mFootViewLable.numberOfLines = 0;
    [self.mFootViewLable setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [self.mFootViewLable setTextColor:ssRGBHex(0x8C9091)];
    [mFootView addSubview:self.mFootViewLable];
    [self.mFootViewLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mFootView);
//        make.height.offset(14);
        
        make.left.equalTo(mFootView).mas_offset(15);
        make.right.equalTo(mFootView).mas_offset(-15);
        make.top.equalTo(mFootView).offset(13);
    }];
    self.mFootViewLable.textAlignment = NSTextAlignmentLeft;
    if(self.MessageSwitch.isOn){
        self.mFootViewLable.text = @"消息通知已打开,您将可以更快了解您的汇款状态.";
    }else{
         self.mFootViewLable.text = @"消息通知已关闭,打开汇款实时通知,可以更快了解您的汇款状态.";
    }
    return mFootView;
}

-(void)switchAction:(id)sender
{   self.mFootViewLable.textAlignment = NSTextAlignmentLeft;
    if (self.MessageSwitch.isOn) {
        self.mFootViewLable.text = @"消息通知已打开,您将可以更快了解您的汇款状态.";
        
    }else {
     self.mFootViewLable.text = @"消息通知已关闭,打开汇款实时通知,可以更快了解您的汇款状态.";
       
    }
}
@end
