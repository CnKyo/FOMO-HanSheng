//
//  CLHistoryRefund.m
//  FOMOPay
//
//  Created by Lever on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryConfirmRefund.h"

@interface CLHistoryConfirmRefund ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *mData;
@end

@implementation CLHistoryConfirmRefund

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认退款账户";
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
    self.mData=@[@"退款会有一定的金额损失，请谨慎操作！",@"请确认您的退款账户，以便安全退款",@"银行名",@"开户城市",@"帐号名称",@"账户号码"];
    [self LoadCellType:9];
    [self LoadButtonConfirmPayAndBackAlter];
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
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    cell.mLeftName.text = [self.mData objectAtIndex:indexPath.row];
    cell.mLeftName.font = kCommonFont(14);
    if(indexPath.row == 0){
        cell.mRightData.hidden = YES;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        cell.mLeftName.textColor = ssRGBHex(0xD50037);
    }else if(indexPath.row == 1){
        cell.mRightData.hidden = YES;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        cell.mLeftName.font = kCommonFont(14);
    }else  if(indexPath.row == 2){
        [cell mTitleViewStyle:0];
        cell.BankLabel.text = @"13"; ////显示银行名
        
        
    }else{
        cell.mRightData.text = @"3213"; //显示除了银行外的其他数据;
        
    }

     return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 ||indexPath.row == 1){
        return 31;
    }else{
    return 49;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = ssRGBHex(0xFFFFFF);
    UIView *mLine = [UIView new];
    mLine.backgroundColor = ssRGBHex(0xE6E6E6);
    [view addSubview:mLine];
    [mLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(15);
        make.right.equalTo(view);
        make.height.offset(1);
        make.width.offset(kScreenWidth);
        
    }];
    return view;
   
}



-(void)LoadButtonConfirmPayAndBackAlter{
    UIButton *ConfirmPayButton = [[UIButton alloc]init];
    
    UIButton *BackAlterButton = [[UIButton alloc]init];
    [ConfirmPayButton addTarget:self action:@selector(ConfirmPayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [BackAlterButton addTarget:self action:@selector(BackAlterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    ConfirmPayButton.backgroundColor = ssRGBHex(0xF6F5FA);
    
    BackAlterButton.backgroundColor = ssRGBHex(0x005CB6);
    
    ConfirmPayButton.layer.borderColor = ssRGBHex(0x005CB6).CGColor;
    
    ConfirmPayButton.layer.borderWidth = 1;
    
    ConfirmPayButton.layer.cornerRadius = 5;
    
    BackAlterButton.layer.cornerRadius = 5;
    
    [ConfirmPayButton setTitle:@"确定退款" forState:UIControlStateNormal];
    
    [BackAlterButton setTitle:@"返回修改" forState:UIControlStateNormal];
    
    [ConfirmPayButton setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    
    [self.view addSubview:BackAlterButton];
    
    [self.view addSubview:ConfirmPayButton];
    //s设置2个按钮平分的约束
    [ConfirmPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        make.left.equalTo(self.view).mas_offset(4);
        make.width.offset(kScreenWidth /2);
        make.height.offset(42);
        make.right.equalTo(BackAlterButton.mas_left).mas_offset(-4);
    }];
    [BackAlterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        //          make.left.equalTo(CancelButton.mas_right).offset(-10);
        make.right.equalTo(self.view).mas_offset(-4);
        make.width.equalTo(ConfirmPayButton.mas_width);
        make.height.offset(42);
    }];
}

-(void)ConfirmPayButton:(UIButton *)sender{
    CLHistoryRefund *vc = [CLHistoryRefund new];
    [self pushToViewController:vc];
}

-(void)BackAlterButton:(UIButton *)sender{
    
}
@end
