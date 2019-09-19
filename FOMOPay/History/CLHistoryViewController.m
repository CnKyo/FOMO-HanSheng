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
@property(nonatomic,strong)UIImageView *ctView;
@property(nonatomic,strong)UILabel *ctLbale;
@end

@implementation CLHistoryViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self headerLoadData];
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
    self.ctView = [UIImageView new];
     self.ctLbale  = [UILabel new];
    __weak typeof(self)  weakSelf = self;
    self.mTabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerLoadData];
        [weakSelf.mTabView.mj_header endRefreshing];
    }];
    
    self.mTabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerLoadData];
        [weakSelf.mTabView.mj_footer endRefreshing];
    }];
    
}
- (void)headerLoadData{
    self.mPage--;
    if (self.mPage<=0) {
        self.mPage = 0;
    }
    [self showLoading:nil];
    
    [WKNetWorkManager WKGetOrderList:@{@"skip":[NSString stringWithFormat:@"%ld",self.mPage],@"take":@"50"} block:^(id result, BOOL success) {
        [self hiddenLoading];
        [self.DataSource removeAllObjects];
        if (success) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"orders"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [mResponse objectForKey:@"orders"]) {
                    
                    [self.DataSource addObject:[WKOrderInfo yy_modelWithDictionary:dic]];
                }
            }
//            [self.DataSource addObjectsFromArray:mTempArr];
            
        }else{
            TOASTMESSAGE(result);
        }
        if(self.DataSource.count <= 0){
//            [self.mTabView reloadData];
            
            [self LoadNoDataView];//没有数据显示暂无历史消息界面
        }else{
            
            [self.ctView removeFromSuperview];
            [self.ctLbale removeFromSuperview];
//            self.ctLbale.hidden = YES;
//            self.ctView.hidden = YES;
            [self.mTabView reloadData];
        }
    }];
}
- (void)footerLoadData{
    self.mPage ++;
    [self showLoading:nil];
    
    [WKNetWorkManager WKGetOrderList:@{@"skip":[NSString stringWithFormat:@"%ld",self.mPage],@"take":@"50"} block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            NSMutableArray *mTempArr = [NSMutableArray new];
            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"orders"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [mResponse objectForKey:@"orders"]) {
                    
                    [mTempArr addObject:[WKOrderInfo yy_modelWithDictionary:dic]];
                }
            }
            [self.DataSource addObjectsFromArray:mTempArr];
        }else{
            TOASTMESSAGE(result);
        }
        if(self.DataSource.count <= 0){
//            [self.mTabView reloadData];
            [self LoadNoDataView];//没有数据显示暂无历史消息界面
            
        }else{
            [self.ctView removeFromSuperview];
            [self.ctLbale removeFromSuperview];
//            self.ctView.hidden = YES;
//            self.ctLbale.hidden = YES;
            [self.mTabView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{  //设置有多少组
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ //设置每个组有多少个
    return self.DataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLHiStoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[CLHiStoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    WKOrderInfo *mItem = self.DataSource[indexPath.row];
///////-----------------------
    if ([CLTool WKGetOrderStatus:mItem.status] == WKOrderStatus_Processing || [CLTool WKGetOrderStatus:mItem.status] == WKOrderStatus_Refunding) {
        [cell mCLHistoryHomeCellStyle:0];  /////样式0为处理中状态跟汇款中状态跟申请退款状态
    }else if ([CLTool WKGetOrderStatus:mItem.status] == WKOrderStatus_Fail){
        [cell mCLHistoryHomeCellStyle:1];  /////样式1为汇款出错状态
    }else if ([CLTool WKGetOrderStatus:mItem.status] == WKOrderStatus_Cancel){
        [cell mCLHistoryHomeCellStyle:2];  /////样式2取消汇款状态
    }else if ([CLTool WKGetOrderStatus:mItem.status] == WKOrderStatus_Sucess){
      [cell mCLHistoryHomeCellStyle:3];    /////样式3汇款完成跟退款成功状态
    }else{
        [cell mCLHistoryHomeCellStyle:1];  /////样式1为汇款出错状态
    }
    [cell setMItem:mItem];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLHistoryRemittancePlan *vc = [CLHistoryRemittancePlan new];
//    CLHistoryRefundProgress *vc =[CLHistoryRefundProgress new];
    vc.mItem = self.DataSource[indexPath.row];
    [self pushToViewController:vc];
}


-(void)LoadNoDataView{
//    self.ctView = [UIImageView new];
    _ctView.image = [UIImage yh_imageNamed:@"pdf_history_home"];
    [self.view addSubview:_ctView];
//    self.ctLbale  = [UILabel new];
    _ctLbale.text = @"暂无历史消息";
    _ctLbale.font = kCommonFont(16);
    _ctLbale.textColor = ssRGBHex(0x2b2b2b);
    [self.view addSubview:_ctLbale];
    [_ctView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(+kAppStatusBarHeight +44 + 143);
        make.centerX.equalTo(self.view);
    }];
    
    [_ctLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ctView.mas_bottom).offset(5);
        make.centerX.equalTo(self.ctView);
    }];
}
@end
