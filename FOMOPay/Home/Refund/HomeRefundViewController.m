//
//  HomeRefundViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeRefundViewController.h"
#import "HomeRefundListCell.h"
#import "HomeSelectPayeeViewController.h"

@interface HomeRefundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *bank;

@end

@implementation HomeRefundViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款进度";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    
    [self loadTableView];
}

- (void)loadTableView{
    
    NSInteger bottomSafeHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        
        UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
        bottomSafeHeight = safeArea.bottom;
        
    }else{
        
        bottomSafeHeight = 0;
    }
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10-bottomSafeHeight);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeRefundListCell" bundle:nil] forCellReuseIdentifier:@"HomeRefundListCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeRefundListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRefundListCell"];
    if (!cell) {
        
        cell = [[HomeRefundListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeRefundListCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak __typeof(self)weakSelf = self;
    
    [cell updateTitle:_unitString];
    cell.HomeRefundListCellBlock = ^(NSString *string, NSInteger tag) {
        
        if (tag == 3000) {  //城市
            
            weakSelf.city = string;
            
        }else if (tag == 3001){ //账户名称
            
            weakSelf.name = string;
            
        }else if (tag == 3002){ //账户号码
            
            weakSelf.number = string;

        }else { //开户银行
            
            weakSelf.bank = string;
        }
    };
    
    cell.HomeRefundListCellButtonBlock = ^{
        
        [weakSelf WKAddRefundAccount];
    };
    
    return cell;
}

- (void)WKAddRefundAccount{
    WS(weakSelf);
    NSMutableDictionary *para = [NSMutableDictionary new];
    if (self.city.length>0) {
        [para setObject:self.city forKey:@"city"];
    }
    if (self.name.length>0) {
        [para setObject:self.name forKey:@"name"];
    }
    if (self.number.length>0) {
        [para setObject:self.number forKey:@"number"];
    }
    if (self.bank.length>0) {
        [para setObject:self.bank forKey:@"bank"];
    }
    
    [self showLoading:nil];
    
    [WKNetWorkManager WKAddRefundAccount:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            //下一步
            if (self.mPushType == HomeRefundViewControllerPushType_refundList) {
                if (self.mBackBlock) {
                    self.mBackBlock(YES);
                }
                [self popToViewController];
            }else{
                HomeSelectPayeeViewController *vc = [[HomeSelectPayeeViewController alloc] init];
                vc.type = ShowButtonTypeDefault;
                vc.mCurrentRemmitance = self.mCurrentRemmitance;
                [weakSelf pushToViewController:vc];
            }
         
        }else{
            TOASTMESSAGE(result);
        }
    }];
}

@end
