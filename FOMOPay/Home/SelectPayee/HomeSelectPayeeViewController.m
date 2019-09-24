//
//  HomeSelectPayeeViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/26.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeSelectPayeeViewController.h"
#import "HomeSelectPayeeListCell.h"
#import "HomeSureInfoViewController.h"
#import "HomeChangePayeeVC.h"
#import "HomeRefundViewController.h"
#import "CLCollectionAdd.h"
@interface HomeSelectPayeeViewController ()<UITableViewDelegate,UITableViewDataSource,CLCollectionAddDelegate>

//@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *mData;
@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *changeButton;
//@property (nonatomic, assign)BOOL ifSelected;//是否选中

@end

@implementation HomeSelectPayeeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_type == ShowButtonTypeDefault){
        self.mInx = nil;
        
    
    }
    [self loadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择收款人";
    if (self.mItem.id.length<=0) {
        self.mItem = [WKResipientInfoObj new];
    }
    
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
//    self.ifSelected = NO;//是否被选中 默认为NO
    [self LoadCellType:10];
//   
    [self loadButtonView];
    
    self.mTabView.backgroundColor = [UIColor clearColor];
    
//    self.mTabView.tableFooterView =
    
    
    
    UIView *mbgView = [UIView new];
    mbgView.backgroundColor = [UIColor clearColor];
//    mbgView.backgroundColor = ssRGBHex(0xF6F5FA);
//    mbgView.backgroundColor= [UIColor redColor];
    mbgView.frame = CGRectMake(0, 12,kScreenWidth , 55);
    UIView *mButtonView = [UIView new];
    mButtonView.backgroundColor = [UIColor clearColor];
//    mButtonView.backgroundColor = [UIColor redColor];
    mButtonView.layer.cornerRadius = 4;
    mButtonView.layer.borderWidth = 1;
    mButtonView.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    [mbgView addSubview:mButtonView];
    
    
    UIButton *addButton = [[UIButton alloc] init];  //添加新收款人
    //                           WithFrame:CGRectMake(50, 0, mButtonView.frame.size.width, mButtonView.frame.size.height)];
    [addButton setTitle:@"添加新收款人" forState:UIControlStateNormal];
    [addButton setImage:[UIImage yh_imageNamed:@"pdf_home_selectPayee_add_icon"] forState:UIControlStateNormal];
    addButton.layer.cornerRadius = 4;
    [addButton setTitleColor:kCommonColor(140, 144, 145, 1) forState:UIControlStateNormal];
    addButton.titleLabel.font = kCommonFont(14);
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    
    [mButtonView addSubview:addButton];
    
    //
    [mButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mbgView).mas_offset(10);
        make.right.equalTo(mbgView).mas_offset(-10);
        make.height.offset(44);
        make.top.equalTo(mbgView).offset(10);
    }];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mButtonView);
        make.height.equalTo(mButtonView.mas_height);
        make.width.equalTo(mButtonView.mas_width);
        
    }];
    
    self.mTabView.tableFooterView = mbgView;
    
    [self ResetLayoutSelect];
//    __weak typeof(self)  weakSelf = self;
//    self.mTabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf.mTabView reloadData];
//        [weakSelf.mTabView.mj_header endRefreshing];
//    }];
//
//    self.mTabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf.mTabView reloadData];
//        [weakSelf.mTabView.mj_footer endRefreshing];
//    }];

}
- (void)CLNavBackAction{
    if (self.backVCS == 2) {
        [self popToViewController:self.backVCS];
    }else{
        [self popToViewController];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mData.count;
//    return  3;
   
}
-(NSMutableArray *)mData{
    if(!_mData){
        _mData = [NSMutableArray new];
    }
    return _mData;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    CLHistorySelctOfPayeeView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[CLHistorySelctOfPayeeView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.mTabView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    if(_type == ShowButtonTypeDefault){
//    if (self.ifSelected) {
//        [cell mCellStyle:0];
//    }else{
//        [cell mCellStyle:1];
//    }
//    }else{
//        if(self.lastIndex != nil && self.lastIndex.row == indexPath.row){
////        if(self.mInx.row == indexPath.row){
//             [cell mCellStyle:0];
//        }else{
//            [cell mCellStyle:1];
//        }
//
//    }
    
    [cell setMItem:self.mData[indexPath.row]];
    if(self.mInx != nil && self.mInx.row == indexPath.row){
        [cell mCellStyle:0];
        self.mItem = self.mData[indexPath.row];  
    }else{
        [cell mCellStyle:1];
    }
    DebugLog(@"%@",self.mItem);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if(_type ==ShowButtonTypeDefault){
//    NSIndexPath * temp = self.lastIndex;//暂存上一次选中的行
//    if (temp && temp != indexPath)//如果上一次的选中的行存在,并且不是当前选中的这一行,则让上一行不选中
//    {
//        self.ifSelected = NO;//修改之前选中的cell的数据为不选中
//        [tableView reloadRowsAtIndexPaths:@[temp] withRowAnimation:UITableViewRowAnimationAutomatic];//刷新该行
//    }
//    self.lastIndex = indexPath;//选中的修改为当前行
//    self.ifSelected = YES;//修改这个被选中的一行
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    self.mItem = self.mData[indexPath.row];
//    self.ifSelected = NO;
//    DebugLog(@"我最后选中了好多%ld行",(long)_lastIndex.row);
//
//    }else{
//        DebugLog(@"跳转界面还有%ld",self.mInx.row);
//        self.mInx = indexPath;
//        [self.mTabView reloadData];
//        self.mItem = self.mData[indexPath.row];
//    }
    self.mInx = indexPath;
    [self.mTabView reloadData];
    
    
    
}
- (void)loadButtonView{

    NSInteger bottomSafeHeight = 0;

    if (@available(iOS 11.0, *)) {

        UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
        bottomSafeHeight = safeArea.bottom;

    }else{

        bottomSafeHeight = 0;
    }

    if (_type == ShowButtonTypeDefault) {

        _nextButton = [[UIButton alloc] init];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.titleLabel.font = kCommonFont(14);
        _nextButton.layer.cornerRadius = 5.0;
//        _nextButton.enabled = NO;
        _nextButton.backgroundColor = ssRGBHex(0x005CB6);
//        kCommonColor(140, 144, 145, 1);
        [_nextButton addTarget:self action:@selector(nextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_nextButton];

        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.bottom.equalTo(self.view).offset(-10-bottomSafeHeight);
            make.height.equalTo(@44);
        }];

    }else{

        CGFloat w = (kScreenWidth - 12)/2;

        _changeButton = [[UIButton alloc] init];
        [_changeButton setTitle:@"修改此收款人" forState:UIControlStateNormal];
        [_changeButton setTitleColor:kLoginTitleColor forState:UIControlStateNormal];
        _changeButton.titleLabel.font = kCommonFont(14);
        _changeButton.layer.cornerRadius = 2;
        _changeButton.backgroundColor = ssRGBHex(0xF6F5FA);
        _changeButton.layer.borderWidth = 1.0;
        _changeButton.layer.borderColor = kLoginTitleColor.CGColor;
        _changeButton.tag = 2000;
        [_changeButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_changeButton];

        [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.view).offset(4);
            make.bottom.equalTo(self.view).offset(-10-bottomSafeHeight);
            make.height.equalTo(@44);
            make.width.mas_equalTo(w);
        }];

        UIButton *sureButton = [[UIButton alloc] init];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureButton.titleLabel.font = kCommonFont(14);
        sureButton.layer.cornerRadius = 2;
        sureButton.backgroundColor = kLoginTitleColor;
        sureButton.tag = 2001;
        [sureButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureButton];

        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.changeButton.mas_right).offset(4);
            make.right.equalTo(self.view).offset(-4);
            make.bottom.equalTo(self.view).offset(-10-bottomSafeHeight);
            make.height.equalTo(@44);
        }];
    }
}


- (void)bottomButtonClicked:(UIButton *)sender{
    WS(weakSelf);
        if (sender.tag == 2000) {   //修改
            if (self.mItem.id.length<=0) {
                TOASTMESSAGE(@"Please select recipient infomation!");
                return;
            }
            HomeChangePayeeVC *vc = [[HomeChangePayeeVC alloc] init];
            vc.mItem = self.mItem;
            
            vc.mBackBlock = ^(WKResipientInfoObj * _Nonnull mItem, NSInteger backCount) {
                weakSelf.mItem = mItem;
           
            };
//            vc.mDeleteBlock = ^(BOOL success) {
//                if(success){
//                    self.mInx = nil;
//                }
//            };
            [self pushToViewController:vc];
    
        }else{  //确认
    
            if (self.mBlock) {
                self.mBlock(self.mItem);
            }
            [self popToViewController];
        }
    }
    //

- (void)loadData{
    [self showLoading:nil];
    [WKNetWorkManager WKGetRecipient:@{@"skip":@"0",@"take":@"50"} block:^(id result, BOOL success) {
        self.mItem = nil;
        [self.mData removeAllObjects];
        [self hiddenLoading];
        if (success) {
            
            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"recipients"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [mResponse objectForKey:@"recipients"]) {
                    
                    WKResipientInfoObj *mRefundAcc = [WKResipientInfoObj yy_modelWithDictionary:dic];
                    [self.mData addObject:mRefundAcc];
                    
//
                }
            }

        }else{
            TOASTMESSAGE(result);
        }
       
        [self.mTabView reloadData];
    }];
}

- (void)addButtonClicked{
    WS(weakSelf);

    CLCollectionAdd *vc = [CLCollectionAdd new];
    vc.mBackBlock = ^(BOOL success) {
        if (success) {
            [weakSelf loadData];
        }
    };
    [self pushToViewController:vc];
}

- (void)nextButtonClicked{
    if (self.mItem.id.length<=0) {
        TOASTMESSAGE(@"Please select recipient infomation!");
        return;
    }
    HomeSureInfoViewController *vc = [[HomeSureInfoViewController alloc] init];
    vc.mItem = self.mItem;
    vc.mInx = self.mInx;
    vc.mCurrentRemmitance = self.mCurrentRemmitance;

    [self pushToViewController:vc];

}




@end
