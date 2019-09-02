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
@property (nonatomic,strong)NSArray *mData;
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
    [self LoadButton];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


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
    __block typeof(self) WeakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消汇款" message:@"是否要取消本次汇款" preferredStyle:UIAlertControllerStyleAlert];
    __block  UIAlertAction *NoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    __block UIAlertAction *YesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      
            if(YesAction){
                CLHistoryCancelRemittance *vc = [CLHistoryCancelRemittance new];
                [self pushToViewController: vc];
            }
        
    }];
    [NoAction setValue:ssRGBHex(0x8C9091) forKey:@"titleTextColor"];
    [alertController addAction:NoAction];
    [alertController addAction:YesAction];
    
    [WeakSelf presentViewController:alertController animated:YES completion:nil];
}

-(void)QueryButton:(UIButton *)sender{
    CLHistoryPaymentdetails *vc = [CLHistoryPaymentdetails new];
    [self pushToViewController:vc];
}

@end
