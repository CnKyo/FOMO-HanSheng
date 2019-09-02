//
//  CLHistoryRefund.m
//  FOMOPay
//
//  Created by Lever on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRefund.h"

@interface CLHistoryRefund ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *mData;
@property (nonatomic,strong) NSArray *mRightData;
@end

@implementation CLHistoryRefund


- (void)viewDidLoad {
        [super viewDidLoad];
        
        self.title = @"退款";
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
        self.mData=@[@"退款会有一定的金额损失，请谨慎操作！",@"请检查退款详情",@"订单号",@"汇款金额",@"出售汇率",@"买入汇率",@"退款金额"];
        self.mRightData=@[@"退款会有一定的金额损失，请谨慎操作！",@"请确认您的退款账户，以便安全退款",@"R201906061234",@"SGD1000.00",@"5.0200",@"5.0780",@"SGD 990.00"];
        [self LoadCellType:9];
        [self LoadSubmitButton];
        [self ResetLayout];
    
        
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
        cell.mLeftName.text = [self.mData objectAtIndex:indexPath.row];
        cell.mLeftName.textAlignment = NSTextAlignmentLeft;
        cell.mRightData.text = [_mRightData objectAtIndex:indexPath.row];
        cell.mRightData.textAlignment = NSTextAlignmentRight;
        if(indexPath.row == 0){
            cell.mRightData.hidden = YES;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            cell.mLeftName.font = kCommonFont(14);
            cell.mLeftName.textColor = ssRGBHex(0xD50037);
        }
        if(indexPath.row == 1){
            cell.mRightData.hidden = YES;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            cell.mLeftName.font = kCommonFont(14);
        }
        
        
        return cell;
        
    }
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if(indexPath.row == 0){
            return 31;
        }else if(indexPath.row == 1){
            return 31;
        }else{
            return 49;
        }
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    }



-(void)LoadSubmitButton{
    UIButton *SubmitButton = [UIButton new];
    SubmitButton.backgroundColor = ssRGBHex(0x005CB6);
    [SubmitButton setTitle:@"提交" forState:UIControlStateNormal];
    SubmitButton.layer.cornerRadius = 5;
    [SubmitButton setTitleColor:ssRGBHex(0xFFFFFF) forState:UIControlStateNormal];
    SubmitButton.titleLabel.font =kCommonFont(14);
    [SubmitButton addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SubmitButton];
    [SubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        make.height.offset(42);
        make.width.offset(kScreenWidth);
    }];
}

-(void)Submit:(UIButton *)sender{
    CLHistoryAuthentication *vc = [CLHistoryAuthentication new];
    [self pushToViewController:vc];
}
@end
