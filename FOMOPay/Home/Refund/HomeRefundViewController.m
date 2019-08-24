//
//  HomeRefundViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeRefundViewController.h"
#import "HomeRefundListCell.h"

@interface HomeRefundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomeRefundViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CLNavModel *mNewModel = [CLNavModel new];
    mNewModel.mTitle = @"退款账户";
    [self CLAddNavType:CLNavType_default andModel:mNewModel completion:^(NSInteger tag) {
        
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell updateTitle:_unitString];
    cell.HomeRefundListCellBlock = ^(NSString * string, NSInteger tag) {
        
        if (tag == 3000) {  //城市
            
        }else if (tag == 3001){ //账户名称
            
            
        }else { //账户号码
            
            
        }
    };
    
    cell.HomeRefundListCellButtonBlock = ^{
        
        //下一步
    };
    
    return cell;
}


@end
