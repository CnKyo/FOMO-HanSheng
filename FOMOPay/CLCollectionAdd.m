//
//  CLCollectionAdd.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionAdd.h"

@interface CLCollectionAdd ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *mAddLeftDateSource;
@end

@implementation CLCollectionAdd

- (void)viewDidLoad {
    [super viewDidLoad]; self.title = @"选择语言";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
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
    [self LoadCellType:6];
     _mAddLeftDateSource=
    @ [@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"账号号码"];
//    [self loadData];
}

- (void)loadData{
    _mAddLeftDateSource=@ [@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"账号号码"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mAddLeftDateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeLanguage *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.mMeLanguageLeftLabel.text = [_mAddLeftDateSource objectAtIndex:indexPath.row];
    
    
    return cell;
}
@end
