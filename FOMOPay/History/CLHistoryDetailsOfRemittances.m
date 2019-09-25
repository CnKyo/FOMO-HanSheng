//
//  CLHistoryDetailsOfRemittances.m
//  FOMOPay
//
//  Created by clkj on 2019/8/29.
//  Copyright © 2019 王钶. All rights reserved.
//
#import "CLHistoryDetailsOfRemittances.h"
#import "CLHistoryPaymentdetails.h"

@interface CLHistoryDetailsOfRemittances ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) CLHistoryRemittancePlan *vc;
@property (nonatomic,strong)NSArray *mData;
@property (nonatomic,strong)NSArray *mRData;
@property (nonatomic,strong)NSMutableArray *mRightData;
@end
@implementation CLHistoryDetailsOfRemittances
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"汇款详情";
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
    self.mRData=@[self.mItem.serialNumber,self.mItem.recipient.fullName,[NSString stringWithFormat:@"%@%@",self.mItem.remittable.source.currencyCode,self.mItem.remittable.source.amount],self.mItem.remittable.rate,[NSString stringWithFormat:@"%@%@",self.mItem.remittable.target.currencyCode,self.mItem.remittable.target.amount],[NSString stringWithFormat:@"%@%@",self.mItem.remittable.serviceCharge.currencyCode,self.mItem.remittable.serviceCharge.amount],[NSString stringWithFormat:@"%@%@",self.mItem.remittable.chargable.currencyCode,self.mItem.remittable.chargable.amount],[self mStats:self.mItem.status],self.mItem.createdAt];
    
   
    [self ResetLayout];
    
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    //分组数 也就是section数
//    return 1;
//}

//设置每个分组下tableview的行数



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
    cell.mRightData.text = [_mRData objectAtIndex: indexPath.row];
    cell.mRightData.textAlignment = NSTextAlignmentRight;
    if(indexPath.row == 7){
        if([cell.mRightData.text isEqual:@"汇款完成"]){
            cell.mRightData.textColor = ssRGBHex(0x2EB42E);
            [self LoadSureButton];
        }else if([cell.mRightData.text isEqual:@"处理中"]){
             [self LoadButton];
        }else if([cell.mRightData.text isEqual:@"汇款出错"]){
            [self LoadAlterButton];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//----------》-〉-.——-————————————————————
//-----------处理汇款时候的按钮
-(void)LoadButton{
    UIButton *CancelButton = [[UIButton alloc]init];
    
    UIButton *QueryButton = [[UIButton alloc]init];
    [CancelButton addTarget:self action:@selector(CancelButton:) forControlEvents:UIControlEventTouchUpInside];

    [QueryButton addTarget:self action:@selector(QueryButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CancelButton.backgroundColor = ssRGBHex(0xF6F5FA);
    
    QueryButton.backgroundColor = ssRGBHex(0x005CB6);
    
    CancelButton.layer.borderColor = ssRGBHex(0x005CB6).CGColor;
    
    CancelButton.layer.borderWidth = 1;
    
    CancelButton.layer.cornerRadius = 5;
    
    QueryButton.layer.cornerRadius = 5;
    
    [CancelButton setTitle:@"取消汇款" forState:UIControlStateNormal];
    
    [QueryButton setTitle:@"查询付款详情" forState:UIControlStateNormal];
    
    [CancelButton setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    
    [self.view addSubview:QueryButton];
    
    [self.view addSubview:CancelButton];
    //s设置2个按钮平分的约束
    [CancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        make.left.equalTo(self.view).mas_offset(4);
        make.width.offset(kScreenWidth /2);
        make.height.offset(42);
        make.right.equalTo(QueryButton.mas_left).mas_offset(-4);
    }];
    [QueryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
//          make.left.equalTo(CancelButton.mas_right).offset(-10);
        make.right.equalTo(self.view).mas_offset(-4);
        make.width.equalTo(CancelButton.mas_width);
        make.height.offset(42);
    }];
}

-(void)CancelButton:(UIButton *)sender{
    DebugLog(@"点击了取消");
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消汇款" message:@"是否要取消本次汇款" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *mCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [mCancel setValue:[UIColor colorWithRed:140/255.0f green:144/255.0f blue:145/255.0f alpha:1] forKey:@"titleTextColor"];
    
    UIAlertAction *mOk = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showLoading:nil];
        [WKNetWorkManager WKDeleteOrder:self.mItem.serialNumber block:^(id result, BOOL success) {
            [self hiddenLoading];
            if (success) {
                TOASTMESSAGE(@"Cancel successful!");

                
               
                
//                if ([[mResponse objectForKey:@"order"] isKindOfClass:[NSArray class]]) {
//                    for (NSDictionary *dic in [mResponse objectForKey:@"order"]) {
//
//                        [mTempArr addObject:[WKOrderInfo yy_modelWithDictionary:dic]];
//                    }
//                }
                
//                [self.mTabView reloadData];
                [self popToViewController:2];
            }else{
                TOASTMESSAGE(result);
            }
        }];
    }];
    
    [alertController addAction:mCancel];
    
    [alertController addAction:mOk];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)QueryButton:(UIButton *)sender{
   
    CLHistoryPaymentdetails *vc = [CLHistoryPaymentdetails new];
    vc.mItem = self.mItem;
    [self pushToViewController:vc];
    

}



//-------------------------汇款成功时他的按钮
-(void)LoadSureButton{
    UILabel *mLabel = [UILabel new];
    
    mLabel.text = @"您想在次汇款还是获得PDF收据?";
    mLabel.textColor = ssRGBHex(0x005CB6);
    mLabel.font = kCommonFont(16);
    mLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mLabel];
    
    UIButton *AgainPayButton = [[UIButton alloc]init];
    
    UIButton *GetPdfButton = [[UIButton alloc]init];
    [AgainPayButton addTarget:self action:@selector(AgainPayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [GetPdfButton addTarget:self action:@selector(GetPdfButton:) forControlEvents:UIControlEventTouchUpInside];
    
    AgainPayButton.backgroundColor = ssRGBHex(0xF6F5FA);
    
    GetPdfButton.backgroundColor = ssRGBHex(0x005CB6);
    
    AgainPayButton.layer.borderColor = ssRGBHex(0x005CB6).CGColor;
    
    AgainPayButton.layer.borderWidth = 1;
    
    AgainPayButton.layer.cornerRadius = 2;
    
    GetPdfButton.layer.cornerRadius = 2;
    
    [AgainPayButton setTitle:@"再次汇款" forState:UIControlStateNormal];
    
    [GetPdfButton setTitle:@"获得PDF收据" forState:UIControlStateNormal];
    
    [AgainPayButton setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    AgainPayButton.titleLabel.font =kCommonFont(14);
    GetPdfButton.titleLabel.font = kCommonFont(14);
    [self.view addSubview:GetPdfButton];
    
    [self.view addSubview:AgainPayButton];
    //s设置2个按钮平分的约束
    [AgainPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        make.left.equalTo(self.view).mas_offset(4);
        //        make.width.offset(kScreenWidth /2);
        make.height.offset(42);
        make.right.equalTo(GetPdfButton.mas_left).mas_offset(-4);
    }];
    [GetPdfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        //          make.left.equalTo(CancelButton.mas_right).offset(-10);
        make.right.equalTo(self.view).mas_offset(-4);
        make.width.equalTo(AgainPayButton.mas_width);
        make.height.offset(42);
    }];
    [mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(9);
        make.bottom.equalTo(AgainPayButton.mas_top).offset(-12);
    }];
    
}

-(void)AgainPayButton:(UIButton *)sender{
    //再次汇款
    
//    [_vc AgainPayButton:sender];
}

-(void)GetPdfButton:(UIButton *)sender{
    //获得pdf收据
//    [_vc GetPdfButton:sender];
    CLHistoryCertificateOfRemittance *vc = [CLHistoryCertificateOfRemittance new];
    [self pushToViewController: vc];
}


//----------------汇款失败时候的按钮
-(void)LoadAlterButton{
    UIButton *AlterButton = [UIButton new];
    AlterButton.backgroundColor = ssRGBHex(0x005CB6);
    [AlterButton setTitle:@"修改" forState:UIControlStateNormal];
    AlterButton.layer.cornerRadius = 5;
    [AlterButton setTitleColor:ssRGBHex(0xFFFFFF) forState:UIControlStateNormal];
    AlterButton.titleLabel.font =kCommonFont(14);
    [AlterButton addTarget:self action:@selector(AlterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AlterButton];
    [AlterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        make.height.offset(42);
        make.width.offset(kScreenWidth);
    }];
}

-(void)AlterButton:(UIButton *)sender{
    CLHistoryAlterRemittance *vc = [CLHistoryAlterRemittance new];


        [self pushToViewController:vc];
    
    

}

- (NSString *)mStats:(NSString *)status{ //中英文转换
    if ([status isEqualToString:@"pending"]) {
        return @"处理中";
}
    return status;
}

@end
