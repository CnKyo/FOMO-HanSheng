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
@property (strong,nonatomic) WKResipientInfoObj *mItem;

@end

@implementation HomeSelectPayeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择收款人";
    self.mItem = [WKResipientInfoObj new];
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    
    [self LoadCellType:10];
    
//    self.mData=@[@"ang",@"ang",@"ang"];
    //以下为按钮
//    UIButton *mSureButton = [UIButton new];
//    [mSureButton setTitle:@"确认" forState:UIControlStateNormal];
//    mSureButton.layer.cornerRadius  =4;
//    mSureButton.backgroundColor = ssRGBHex(0x005CB6);
//    mSureButton.titleLabel.font = kCommonFont(14);
//    [mSureButton setTitleColor:ssRGBHex(0xFFFFFF) forState:UIControlStateNormal];
//    [mSureButton addTarget:self action:@selector(SureBUtton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:mSureButton];
//
//
//   [mSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).offset(-BottomHeight - 10);
//        make.left.equalTo(self.view).offset(10);
//        make.right.equalTo(self.view).offset(-10);
//        make.height.offset(44);
    
//    }];
    [self loadButtonView];
    [self loadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mData.count;
   
}
-(NSMutableArray *)mData{
    if(!_mData){
        _mData = [NSMutableArray new];
    }
    return _mData;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLHistorySelctOfPayeeView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[CLHistorySelctOfPayeeView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
//    [cell mCellStyle:1];
    //    if(indexPath.row == self.lastIndex.row){
    //        [cell mCellStyle:0];
    //    }else
    //        [cell mCellStyle:1];
    if(indexPath.row ==self.lastIndex.row){
        [cell mCellStyle:0];
    }
//    cell.mName.text  =
    [cell setMItem:self.mData[indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lastIndex=indexPath;
    [self.mTabView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *mbgView = [UIView new];
    mbgView.backgroundColor = ssRGBHex(0xF6F5FA);
    mbgView.frame = CGRectMake(0, 0,kScreenWidth , 45);
    UIView *mButtonView = [UIView new];
    mButtonView.backgroundColor = ssRGBHex(0xFFFFFF);
    mButtonView.layer.cornerRadius = 4;
    mButtonView.layer.borderWidth = 1;
    mButtonView.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    [mbgView addSubview:mButtonView];
    
    
    UIButton *addButton = [[UIButton alloc] init];  //添加新收款人
    //                           WithFrame:CGRectMake(50, 0, mButtonView.frame.size.width, mButtonView.frame.size.height)];
    [addButton setTitle:@"添加新收款人" forState:UIControlStateNormal];
    [addButton setImage:[UIImage yh_imageNamed:@"pdf_home_selectPayee_add_icon"] forState:UIControlStateNormal];
    [addButton setTitleColor:kCommonColor(140, 144, 145, 1) forState:UIControlStateNormal];
    addButton.titleLabel.font = kCommonFont(14);
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    
    [mButtonView addSubview:addButton];
    
    //
    [mButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mbgView).mas_offset(15);
        make.right.equalTo(mbgView).mas_offset(-15);
        make.height.offset(44);
        make.top.equalTo(mbgView).offset(10);
    }];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mButtonView);
        make.height.equalTo(mButtonView.mas_height);
        make.width.equalTo(mButtonView.mas_width);
        
    }];
    return mbgView;
}
//
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 54;
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
        _changeButton.backgroundColor = [UIColor whiteColor];
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
    
        if (sender.tag == 2000) {   //修改
    
            HomeChangePayeeVC *vc = [[HomeChangePayeeVC alloc] init];
            [self pushToViewController:vc];
    
        }else{  //确认
    
    
        }
    }
    //

- (void)loadData{
    [self showLoading:nil];
    [WKNetWorkManager WKGetRecipient:@{@"skip":@"1",@"take":@"50"} block:^(id result, BOOL success) {

        [self.DataSource removeAllObjects];
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

    HomeSureInfoViewController *vc = [[HomeSureInfoViewController alloc] init];
    vc.mItem = self.mItem;
    vc.mCurrentRemmitance = self.mCurrentRemmitance;

    [self pushToViewController:vc];

}



//
//- (void)loadTableView{
//
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
//    footerView.backgroundColor = [UIColor clearColor];
//
//    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, footerView.frame.size.width - 20, footerView.frame.size.height)];
//    [addButton setTitle:@"添加新收款人" forState:UIControlStateNormal];
//    [addButton setImage:[UIImage yh_imageNamed:@"pdf_home_selectPayee_add_icon"] forState:UIControlStateNormal];
//    [addButton setTitleColor:kCommonColor(140, 144, 145, 1) forState:UIControlStateNormal];
//    addButton.titleLabel.font = kCommonFont(14);
//    addButton.backgroundColor = [UIColor whiteColor];
//    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    addButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
//    [footerView addSubview:addButton];
//
////    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
//
//    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _myTableView.dataSource = self;
//    _myTableView.delegate = self;
//    _myTableView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_myTableView];
//
//    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(- BottomHeight - 10 - 44);
//
//        make.top.equalTo(self.view).offset(44 + kAppStatusBarHeight);
//    }];
//
//    [_myTableView registerNib:[UINib nibWithNibName:@"HomeSelectPayeeListCell" bundle:nil] forCellReuseIdentifier:@"HomeSelectPayeeListCell"];
//    _myTableView.tableFooterView = footerView;
//    [self loadData];
//}
//- (void)loadData{
//    [self showLoading:nil];
//    [WKNetWorkManager WKGetRecipient:@{@"skip":@"1",@"take":@"50"} block:^(id result, BOOL success) {
//
//        [self.DataSource removeAllObjects];
//        [self hiddenLoading];
//        if (success) {
//            NSDictionary *mResponse = [CLTool stringToDic:result];
//            if ([[mResponse objectForKey:@"recipients"] isKindOfClass:[NSArray class]]) {
//                for (NSDictionary *dic in [mResponse objectForKey:@"recipients"]) {
//                    WKResipientInfoObj *mRefundAcc = [WKResipientInfoObj yy_modelWithDictionary:dic];
//                    [self.DataSource addObject:mRefundAcc];
//                }
//            }
//
//        }else{
//            TOASTMESSAGE(result);
//        }
//        [self.myTableView reloadData];
//    }];
//}
//- (void)addButtonClicked{
//    WS(weakSelf);
//
//    CLCollectionAdd *vc = [CLCollectionAdd new];
//    vc.mBackBlock = ^(BOOL success) {
//        if (success) {
//            [weakSelf loadData];
//        }
//    };
//    [self pushToViewController:vc];
//}
//
//- (void)nextButtonClicked{
//
//    HomeSureInfoViewController *vc = [[HomeSureInfoViewController alloc] init];
//    vc.mItem = self.mItem;
//    vc.mCurrentRemmitance = self.mCurrentRemmitance;
//
//    [self pushToViewController:vc];
//
//}
//
//- (void)bottomButtonClicked:(UIButton *)sender{
//
//    if (sender.tag == 2000) {   //修改
//
//        HomeChangePayeeVC *vc = [[HomeChangePayeeVC alloc] init];
//        [self pushToViewController:vc];
//
//    }else{  //确认
//
//
//    }
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return self.DataSource.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 100;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    return 0.001;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 0.001;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    return [UIView new];
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    return [UIView new];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    HomeSelectPayeeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSelectPayeeListCell"];
//    if (!cell) {
//
//        cell = [[HomeSelectPayeeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSelectPayeeListCell"];
//
//    }
//    [cell setMItem:self.DataSource[indexPath.row]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    _nextButton.enabled = YES;
//    _nextButton.backgroundColor = kLoginTitleColor;
//
//    HomeSelectPayeeListCell *lastCell = (HomeSelectPayeeListCell *)[tableView cellForRowAtIndexPath:_lastIndex];
//    lastCell.bgImageView.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_bg_gray"];
//    lastCell.selectImage.hidden = YES;
//
//    HomeSelectPayeeListCell *currentCell = (HomeSelectPayeeListCell *)[tableView cellForRowAtIndexPath:indexPath];
//    currentCell.bgImageView.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_bg_grren"];
//    currentCell.selectImage.hidden = NO;
//
//    _lastIndex = indexPath;
//
//    self.mItem = self.DataSource[indexPath.row];
//
//}



@end
