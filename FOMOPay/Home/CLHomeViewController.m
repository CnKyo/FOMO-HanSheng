//
//  CLHomeViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHomeViewController.h"
#import "CLHomeDetailVC.h"
@interface CLHomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property NSArray *Array;
@end

@implementation CLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self setMNavTitle:@"首页"];
//    self.title = @"首页";
//    [self LoadNavType:0]; // ⬇️替换成新的方法
    
//    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
    
    
   // //////////////////////////////////
//    UIButton *btn= [UIButton new];
//    [btn setTitle:@"添加" forState:UIControlStateNormal];
//    [btn setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
//    UIView *mView = [UIView new];
//    [mView addSubview:btn];
//
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(mView).offset(-20);
//        make.top.equalTo(mView).offset(0);
//        make.bottom.equalTo(mView).offset(0);
//    }];

    CLNavModel *model = [CLNavModel new];
    model.mRightView = [CLNavgationView_button shareDefaultNavRightButton]  ;//可以直接调用封装在一起的mView;
    [self CLAddNavType:CLNavType_home andModel:model completion:^(NSInteger tag) {
// [self CLAddNavType:CLNavType_other andModel:nil completion:^(NSInteger tag) {
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
    
    
    [self LoadCellType:2];
   
    // Do any additional setup after loading the view.
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell CellStyle:2];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 81;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLHomeDetailVC *vc = [CLHomeDetailVC new];
    [self pushToViewController:vc];
}
@end
