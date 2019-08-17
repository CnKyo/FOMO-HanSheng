//
//  CLMeLanguageViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/16.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeLanguageViewController.h"

@interface CLMeLanguageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *mMeSwitchDateSource;
@end

@implementation CLMeLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择语言";
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
    _mMeSwitchDateSource = @[@"简体中文",@"English"];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mMeSwitchDateSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeLanguage *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.mMeLanguageLeftLabel.text = [_mMeSwitchDateSource objectAtIndex:indexPath.row];
    UIImageView *SelectedImage=[[UIImageView alloc]init];
    SelectedImage.image=[UIImage yh_imageNamed:@"pdf_me_language_selected"];
   
    [cell.contentView addSubview:SelectedImage];
    [SelectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell).offset(12);
        make.bottom.equalTo(cell).offset(-12);
        make.right.equalTo(cell).offset(-10);
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [UIView new];
    headView.backgroundColor = ssRGBHex(0xF6F6F6);
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
@end
