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

@end

@implementation CLHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadConfig];
}
- (void)loadConfig{
    [self showLoading:nil];
    if ([WKAccountManager shareInstance].appConfig.rmtMaxAmt.length<=0) {
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
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:@"SGD" forKey:@"sourceCurrencyCode"];
    [para setObject:@"1000" forKey:@"sourceAmount"];
    [para setObject:@"CNY" forKey:@"targetCurrencyCode"];

    [WKNetWorkManager WKGetRemiitablePara:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            
        }else{
            TOASTMESSAGE(result);
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListCell"];
    if (!cell) {
        cell = [[HomeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeListCell"];
    }
    cell.type = HomeListCellTypeHome;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.HomeListCellBlock = ^(NSString * _Nonnull string, NSInteger tag) {
        
        if (tag == 4000) {  //汇出
            
            
            
        }else if (tag == 4001){ //获得
            
            
        }else{  //总金额
            
            
        }
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
