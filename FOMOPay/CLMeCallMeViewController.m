//
//  CLMeCallMeViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/16.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeCallMeViewController.h"

@interface CLMeCallMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *mMeCallmeDateSource;
@property (nonatomic,strong) NSArray *mMeCallmeRightDataSource;
@end

@implementation CLMeCallMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
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
    [self LoadCellType:6];
    _mMeCallmeDateSource = @[@"电话",@"传真",@"邮箱",@"地址",@"个人资料保护法案\n(PDPA)相关查询",@"联系技术支持"];
    _mMeCallmeRightDataSource=@[@"+6565386280",@"+6565386288",@"hello@hanshanmoney.com",@"People's Park Complex\n 1 Park Road #02-K87/88\n Singapore 059108",@"pdpa@hanshanmoney.com",@"tech@hanshanmoney.com"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mMeCallmeDateSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeLanguage *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.mMeLanguageLeftLabel.text = [_mMeCallmeDateSource objectAtIndex:indexPath.row];
    cell.mMeLanguageLeftLabel.numberOfLines = 0;//表示label可以多行显示
//    cell.mMeLanguageLeftLabel.lineBreakMode = UILineBreakModeCharacterWrap;//换行模式，与上面的计算保持一致。
    
    UILabel *RightLabel = [UILabel new];
    [cell.contentView addSubview:RightLabel];
    RightLabel.text = [_mMeCallmeRightDataSource objectAtIndex:indexPath.row];
    RightLabel.numberOfLines = 0;//表示label可以多行显示
    RightLabel.textAlignment = NSTextAlignmentRight;
//    RightLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    
    
    
    [RightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell).offset(23);
        make.right.equalTo(cell).offset(-15);
    }];
//    UIImageView *SelectedImage=[[UIImageView alloc]init];
//    SelectedImage.image=[UIImage yh_imageNamed:@"pdf_me_language_selected"];
//
//    [cell.contentView addSubview:SelectedImage];
//    [SelectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(cell).offset(12);
//        make.bottom.equalTo(cell).offset(-12);
//        make.right.equalTo(cell).offset(-10);
//    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 3){
        return 110;
    }else if(indexPath.row == 4){
        return 86;
    }
    return 62;
}
@end
