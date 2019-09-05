//
//  CLHistoryViewController.m
//  FOMOPay
//
//  Created by Lever on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryViewController.h"
#import "CLHistoryRefundProgress.h"
@interface CLHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *mData;
@end

@implementation CLHistoryViewController

-(NSArray *)mData{
    if(_mData == nil){
        _mData = [NSArray new];
    }
    return _mData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
            [self CLAddNavType:CLNavType_home andModel:nil completion:^(NSInteger tag) {
        
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
    [self LoadCellType:3];
    _mData = @[@"a",@"a",@"a",@"a",@"a"];
    [self LoadData];
    
    // Do any additional setup after loading the view.
}

-(void)LoadData{
    if(_mData == nil){
        [self LoadNoDataView];//没有数据显示暂无历史消息界面
    }else{
        [self.mTabView reloadData];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLHiStoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[CLHiStoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
///////-----------------------
//    [cell mCLHistoryHomeCellStyle:0];  /////样式0为处理中状态跟汇款中状态跟申请退款状态
//    [cell mCLHistoryHomeCellStyle:1];  /////样式1为汇款出错状态
//    [cell mCLHistoryHomeCellStyle:2];  /////样式2取消汇款状态
      [cell mCLHistoryHomeCellStyle:3];    /////样式3汇款完成跟退款成功状态
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CLHistoryRemittancePlan *vc = [CLHistoryRemittancePlan new];
//    CLHistoryRefundProgress *vc =[CLHistoryRefundProgress new];
    [self pushToViewController:vc];
}


-(void)LoadNoDataView{
    UIImageView *ctView = [UIImageView new];
    ctView.image = [UIImage yh_imageNamed:@"pdf_history_home"];
    [self.view addSubview:ctView];
    UILabel *ctLbale  = [UILabel new];
    ctLbale.text = @"暂无历史消息";
    ctLbale.font = kCommonFont(16);
    [self.view addSubview:ctLbale];
    [ctView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(+kAppStatusBarHeight +44 + 143);
        make.centerX.equalTo(self.view);
    }];
    
    [ctLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ctView.mas_bottom).offset(5);
        make.centerX.equalTo(ctView);
    }];
}
@end
