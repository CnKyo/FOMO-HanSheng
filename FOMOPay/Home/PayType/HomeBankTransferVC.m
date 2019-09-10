//
//  HomeBankTransferVC.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeBankTransferVC.h"
#import "HomeBankTransferCell.h"

@interface HomeBankTransferVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomeBankTransferVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    self.title = @"银行转账";
    CLNavModel *mNewModel = [CLNavModel new];
//    mNewModel.mTitle = @"银行转账";
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
        make.bottom.equalTo(self.view).offset(-bottomSafeHeight);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height + 1);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeBankTransferCell" bundle:nil] forCellReuseIdentifier:@"HomeBankTransferCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeBankTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBankTransferCell"];
    if (!cell) {
        
        cell = [[HomeBankTransferCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeBankTransferCell"];
//
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak __typeof(self)weakSelf = self;
    cell.HomeBankTransferCellBlock = ^(NSInteger tag) {
        
        if (tag == 0) { //复制
            
            
        }else{  //完成
            
            
        }
    };
    
    return cell;
}

@end
