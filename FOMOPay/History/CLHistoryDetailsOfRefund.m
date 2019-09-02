//
//  CLHistoryDetailsOfRefund.m
//  FOMOPay
//
//  Created by Lever on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryDetailsOfRefund.h"

@interface CLHistoryDetailsOfRefund ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *mData;
@end

@implementation CLHistoryDetailsOfRefund

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款详情";
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
    [self LoadCellType:9];
    self.mData=@[@"订单号",@"收款人",@"汇款金额",@"汇率",@"获得金额",@"手续费",@"总金额",@"状态",@"订单时间"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.mData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLHistoryDetailsOfRemittancesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[CLHistoryDetailsOfRemittancesCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
    if(indexPath.row == 1){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(indexPath.row == 5){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(indexPath.row == 6){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(indexPath.row == 8){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    cell.mLeftName.text= [_mData objectAtIndex:indexPath.row];
    cell.mLeftName.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
