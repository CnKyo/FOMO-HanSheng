//
//  CLHistoryPaymentdetails.m
//  FOMOPay
//
//  Created by clkj on 2019/8/29.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryPaymentdetails.h"

@interface CLHistoryPaymentdetails ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *mRightData;


@end

@implementation CLHistoryPaymentdetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款详情";
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
    

    self.mData=@[@"收款人",@"账户号码",@"关系",@"汇款金额",@"获得金额",@"汇率",@"手续费",@"汇款目的",@"资金来源",@"总金额"];
    
    self.mRightData = @[self.mItem.recipient.fullName,self.mItem.recipient.accountNumber,self.mItem.recipient.relationship,[NSString stringWithFormat:@"%@%@",self.mItem.remittable.source.currencyCode,self.mItem.remittable.source.amount],[NSString stringWithFormat:@"%@%@",self.mItem.remittable.target.currencyCode,self.mItem.remittable.target.amount],self.mItem.remittable.rate,[NSString stringWithFormat:@"%@%@",self.mItem.remittable.serviceCharge.currencyCode,self.mItem.remittable.serviceCharge.amount],self.mItem.purpose,self.mItem.sourceOfFund,[NSString stringWithFormat:@"%@%@",self.mItem.remittable.chargable.currencyCode,self.mItem.remittable.chargable.amount]];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.mData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLHistoryDetailsOfRemittancesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[CLHistoryDetailsOfRemittancesCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
    if(indexPath.row == 2){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(indexPath.row == 6){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(indexPath.row == 9){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    cell.mLeftName.textColor = ssRGBHex(0x8C9091);
    cell.mLeftName.text= [_mData objectAtIndex:indexPath.row];
    cell.mLeftName.textAlignment = NSTextAlignmentLeft;
    
    cell.mRightData.text = [self.mRightData objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
@end
