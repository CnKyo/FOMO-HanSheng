//
//  HomeChangeAmountVC.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeChangeAmountVC.h"
#import "HomeListCell.h"

@interface HomeChangeAmountVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomeChangeAmountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    self.title =@"修改汇款金额";
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.type = HomeListCellTypeChangeAmount;
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

    };
    
    return cell;
}

@end
