//
//  CLHomeViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHomeViewController.h"

#import "HomeListCell.h"
#import "HomeDataObject.h"
#import "HomeRefundViewController.h"
#import "HomeSelectPayeeViewController.h"
@interface CLHomeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, assign) WKRemmitableStatus mStatus;


@property (nonatomic, strong) NSString *mOut;

@property (nonatomic, strong) NSString *mIn;

@property (nonatomic, strong) NSString *mAmount;


@property (nonatomic, strong) NSString *mTotleAmount;
@property (nonatomic, strong) NSString *mFetchAmount;

@end

@implementation CLHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadConfig];
}
- (void)loadConfig{
    if ([WKAccountManager shareInstance].appConfig.rmtMaxAmt.length<=0) {
        [self showLoading:nil];

        [WKNetWorkManager WKGetAppConfig:^(id result, BOOL success) {
            [self hiddenLoading];
            if (success) {
                if ([result isKindOfClass:[NSString class]]) {
                    [[WKAccountManager shareInstance] WKResetAppConfig:result];
                }
            }else{
                TOASTMESSAGE(result);
            }
        }];
    }

  
    [self showLoading:nil];

    self.mOut = @"SGD";
    self.mIn = @"CNY";
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mOut forKey:@"sourceCurrencyCode"];
    [para setObject:@"100" forKey:@"sourceAmount"];
    [para setObject:self.mIn forKey:@"targetCurrencyCode"];
    
    [WKNetWorkManager WKGetRemiitablePara:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            [[WKAccountManager shareInstance] WKResetOutCurrenceCode:self.mOut];
            [[WKAccountManager shareInstance] WKResetInCurrenceCode:self.mIn];
            NSDictionary *dic = [CLTool stringToDic:result];
            WKRemiitableEntity *mEntity = [WKRemiitableEntity yy_modelWithDictionary:[dic objectForKey:@"remittable"]];
            [[WKAccountManager shareInstance] WKResetRate:mEntity.rate];
        }else{
            TOASTMESSAGE(result);
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mStatus = WKRemmitableStatus_out;
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    [self CLAddNavType:CLNavType_home andModel:nil completion:^(NSInteger tag) {
        
    }];
    [self loadTableView];
}

- (void)loadTableView{
    
    NSInteger tabbarHeight = self.tabBarController.tabBar.bounds.size.height;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];

    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10-tabbarHeight);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeListCell" bundle:nil] forCellReuseIdentifier:@"HomeListCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListCell"];
    if (!cell) {
        cell = [[HomeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeListCell"];
    }
    cell.type = HomeListCellTypeHome;
    if (self.mFetchAmount.length>0) {
        cell.myTextField1.text = [NSString stringWithFormat:@"%ld",[self.mFetchAmount integerValue]*[[WKAccountManager shareInstance].mRate integerValue]];
    }
    if (self.mTotleAmount.length>0) {
        cell.myTextField2.text = self.mTotleAmount;
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mSelectedBlock = ^(NSString *mOut, NSString *mIn) {
        
        weakSelf.mOut = mOut;
        weakSelf.mIn = mIn;
        
        [weakSelf caculateAmount];
    };
    cell.HomeListCellBlock = ^(NSString * _Nonnull string, NSInteger tag) {
        weakSelf.mAmount = string;
        if (tag == 4000) {  //汇出
            weakSelf.mStatus = WKRemmitableStatus_out;
        }else if (tag == 4001){ //获得
            weakSelf.mStatus = WKRemmitableStatus_in;
        }else{  //总金额
            weakSelf.mStatus = WKRemmitableStatus_pay;
        }
        [weakSelf caculateAmount];

    };
    
    cell.HomeListCellButtonBlock = ^(NSString * _Nonnull unit) {
        
        NSString *string = nil;
        if ([unit isEqualToString:@"SGD"]) {    //新加坡
            
            string = @"新加坡";
            
        }else if ([unit isEqualToString:@"CNY"]){   //中国
            
            string = @"中国";

        }else if ([unit isEqualToString:@"TWD"]){   //台湾

            string = @"台湾";

        }else if ([unit isEqualToString:@"MYR"]){   //马来西亚

            string = @"马来西亚";

        }else if ([unit isEqualToString:@"HKD"]){   //香港

            string = @"香港";

        }else if ([unit isEqualToString:@"IDR"]){   //印尼

            string = @"印尼";

        }else if ([unit isEqualToString:@"PHP"]){   //菲律宾

            string = @"菲律宾";
        }
       
        [self goRefund:string];
    };

    return cell;
}
- (void)caculateAmount{
    if ([self.mAmount floatValue]<=0) {
        TOASTMESSAGE(@"汇出金额必须大于0");
        return;
    }
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mOut forKey:@"sourceCurrencyCode"];
    [para setObject:self.mAmount forKey:@"sourceAmount"];
    [para setObject:self.mIn forKey:@"targetCurrencyCode"];
    [self showLoading:nil];
    [WKNetWorkManager WKGetRemiitablePara:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            
            [[WKAccountManager shareInstance] WKResetOutCurrenceCode:self.mOut];
            [[WKAccountManager shareInstance] WKResetInCurrenceCode:self.mIn];
            NSDictionary *dic = [CLTool stringToDic:result];
            WKRemiitableEntity *mEntity = [WKRemiitableEntity yy_modelWithDictionary:[dic objectForKey:@"remittable"]];
            [[WKAccountManager shareInstance] WKResetRate:mEntity.rate];
            
            self.mTotleAmount = mEntity.chargable.amount;
            self.mFetchAmount = mEntity.serviceCharge.amount;
            
        }else{
            TOASTMESSAGE(result);
        }
        [self.myTableView reloadData];
    }];
}
- (void)goRefund:(NSString *)text{
    WS(weakSelf);
    [self showLoading:nil];
    [WKNetWorkManager WKGetRefundAccount:@{} block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            
            NSDictionary *dic =  [CLTool stringToDic:result];
            WKRefundAccount *mRefundAcc = [WKRefundAccount yy_modelWithDictionary:[dic objectForKey:@"refundAccount"]];
            if (mRefundAcc.number.length>0) {
                //下一步
                HomeSelectPayeeViewController *vc = [[HomeSelectPayeeViewController alloc] init];
                vc.type = ShowButtonTypeDefault;
                [weakSelf pushToViewController:vc];
            }else{
                //汇款
                HomeRefundViewController *vc = [[HomeRefundViewController alloc] init];
                vc.unitString = text;
                [self pushToViewController:vc];
            }

        }else{
            TOASTMESSAGE(result);
        }
    }];
}
@end
