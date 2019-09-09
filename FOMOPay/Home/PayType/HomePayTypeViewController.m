//
//  HomePayTypeViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomePayTypeViewController.h"
#import "HomePayTypeListCell.h"

#import "HomePayNowViewController.h"    //paynow

@interface HomePayTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomePayTypeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    self.title =@"支付方式";

    CLNavModel *mNewModel = [CLNavModel new];
    mNewModel.mTitle = @"支付方式";
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
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height + 1);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomePayTypeListCell" bundle:nil] forCellReuseIdentifier:@"HomePayTypeListCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePayTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePayTypeListCell"];
    if (!cell) {
        
        cell = [[HomePayTypeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePayTypeListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    __weak __typeof(self)weakSelf = self;
    
    cell.HomePayTypeListCellBlock = ^(NSInteger tag) {
      
        if (tag == 0) {
            
            HomePayNowViewController *vc = [[HomePayNowViewController alloc] init];
            [weakSelf pushToViewController:vc];
            
        }else{
            
            
        }
    };
    
    return cell;
}


@end
