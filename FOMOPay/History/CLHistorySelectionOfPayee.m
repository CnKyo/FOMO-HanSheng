//
//  CLHistorySelectionOfPayee.m
//  FOMOPay
//
//  Created by clkj on 2019/9/3.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistorySelectionOfPayee.h"


#import "HomeSelectPayeeViewController.h"
#import "HomeSelectPayeeListCell.h"
#import "HomeSureInfoViewController.h"
#import "HomeChangePayeeVC.h"
@interface CLHistorySelectionOfPayee ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSIndexPath *lastIndex;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *changeButton;
@end

@implementation CLHistorySelectionOfPayee

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择收款人";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    
    
}



@end
