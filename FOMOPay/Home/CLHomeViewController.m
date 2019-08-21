//
//  CLHomeViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHomeViewController.h"
#import "CLHomeDetailVC.h"
#import "HomeListCell.h"
#import "HomeDataObject.h"

#import "LogInViewController.h"

@interface CLHomeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIButton *OpenExchangerate;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation CLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
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

- (void)exchageerateButtonClicked{
    
    LogInViewController *VC = [[LogInViewController alloc] init];
    [self pushToViewController:VC];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.HomeListCellBlock = ^(NSString * _Nonnull string, NSInteger tag) {
        
        if (tag == 4000) {  //汇出
            
            
            
        }else if (tag == 4001){ //获得
            
            
        }else{  //总金额
            
            
        }
    };
    
    cell.HomeListCellButtonBlock = ^{
        
        //汇款
   
    };
    
    return cell;
}

@end
