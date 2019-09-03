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
@interface HomeSelectPayeeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation HomeSelectPayeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择收款人";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    
    [self initialView];
}

- (void)initialView{
    
    [self loadButtonView];
    
    [self loadTableView];
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
        _nextButton.enabled = NO;
        _nextButton.backgroundColor = kCommonColor(140, 144, 145, 1);
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

- (void)loadTableView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, footerView.frame.size.width - 20, footerView.frame.size.height)];
    [addButton setTitle:@"添加新收款人" forState:UIControlStateNormal];
    [addButton setImage:[UIImage yh_imageNamed:@"pdf_home_selectPayee_add_icon"] forState:UIControlStateNormal];
    [addButton setTitleColor:kCommonColor(140, 144, 145, 1) forState:UIControlStateNormal];
    addButton.titleLabel.font = kCommonFont(14);
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [footerView addSubview:addButton];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.type == ShowButtonTypeDefault ? self.nextButton.mas_top:self.changeButton.mas_top).offset(-10);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height + 10);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeSelectPayeeListCell" bundle:nil] forCellReuseIdentifier:@"HomeSelectPayeeListCell"];
    _myTableView.tableFooterView = footerView;
    [self loadData];
}
- (void)loadData{
    [self showLoading:nil];
    [WKNetWorkManager WKGetRefundAccount:@{} block:^(id result, BOOL success) {
        [self.DataSource removeAllObjects];
        [self hiddenLoading];
        if (success) {
            NSDictionary *dic =  [CLTool stringToDic:result];
            WKRefundAccount *mRefundAcc = [WKRefundAccount yy_modelWithDictionary:[dic objectForKey:@"refundAccount"]];
            [self.DataSource addObject:mRefundAcc];
        }else{
            TOASTMESSAGE(result);
        }
        [self.myTableView reloadData];
    }];
}
- (void)addButtonClicked{
    WS(weakSelf);
    //添加收款人
    HomeRefundViewController *vc = [[HomeRefundViewController alloc] init];
    vc.mPushType = HomeRefundViewControllerPushType_refundList;
    vc.mBackBlock = ^(BOOL isRefresh) {
        if (isRefresh) {
            [weakSelf loadData];
        }
    };
    [self pushToViewController:vc];
}

- (void)nextButtonClicked{
    
    [self showLoading:nil];
    
    [WKNetWorkManager WKGetRecipient:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            //下一步
            HomeSureInfoViewController *vc = [[HomeSureInfoViewController alloc] init];
            [self pushToViewController:vc];
        }else{
            TOASTMESSAGE(result);
        }
    }];
}

- (void)bottomButtonClicked:(UIButton *)sender{
    
    if (sender.tag == 2000) {   //修改
        
        HomeChangePayeeVC *vc = [[HomeChangePayeeVC alloc] init];
        [self pushToViewController:vc];
        
    }else{  //确认
        
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.DataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeSelectPayeeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSelectPayeeListCell"];
    if (!cell) {
        
        cell = [[HomeSelectPayeeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSelectPayeeListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setMItem:self.DataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _nextButton.enabled = YES;
    _nextButton.backgroundColor = kLoginTitleColor;
    
    HomeSelectPayeeListCell *lastCell = (HomeSelectPayeeListCell *)[tableView cellForRowAtIndexPath:_lastIndex];
    lastCell.bgImageView.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_bg_gray"];
    lastCell.selectImage.hidden = YES;
    
    HomeSelectPayeeListCell *currentCell = (HomeSelectPayeeListCell *)[tableView cellForRowAtIndexPath:indexPath];
    currentCell.bgImageView.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_bg_grren"];
    currentCell.selectImage.hidden = NO;
    
    _lastIndex = indexPath;
}



@end
