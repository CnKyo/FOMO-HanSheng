//
//  CLHistoryAlterRemittance.m
//  FOMOPay
//
//  Created by clkj on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryAlterRemittance.h"

@interface CLHistoryAlterRemittance ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *mData;
@end

@implementation CLHistoryAlterRemittance
-(NSArray *)mData{
    if(_mData == nil){
        _mData = [NSArray new];

    }
    return  _mData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改汇款信息";
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mBtView = [CLNavgationView_button shareDefaultNavRightButtonAlter];
    model.mRightView = mBtView ;
    mBtView.mRightBtnBlock = ^(NSInteger tag) {
        if(tag == 101){
            //跳转申请退款界面;
        }
    };
    [self CLAddNavType:CLNavType_other andModel:model completion:^(NSInteger tag) {
        
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
    [self LoadContactAndConfirm];
   [self ResetLayout];  //底部按钮适配5s的约束
    
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
    if(indexPath.row == 0){
        cell.mLeftName.text = @"无效的账号:";
        cell.mLeftName.textColor = ssRGBHex(0xD50037);
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.mRightData.text = @"请更正账户号码或者更换汇款账号";
        cell.mRightData.textAlignment = NSTextAlignmentLeft;
    }else if(indexPath.row == 5){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(indexPath.row == 6){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(indexPath.row == 8){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
//    cell.mLeftName.text= [_mData objectAtIndex:indexPath.row];
//    cell.mLeftName.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 41;
    }
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




















/////------------------底部按钮以及他的事件
-(void)LoadContactAndConfirm{
    UIButton *ContactButton = [[UIButton alloc]init];
    
    UIButton *ConfirmButton = [[UIButton alloc]init];
    [ContactButton addTarget:self action:@selector(ContactButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [ConfirmButton addTarget:self action:@selector(ConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    
    ContactButton.backgroundColor = ssRGBHex(0xF6F5FA);
    
    ConfirmButton.backgroundColor = ssRGBHex(0x005CB6);
    
    ContactButton.layer.borderColor = ssRGBHex(0x005CB6).CGColor;
    
    ContactButton.layer.borderWidth = 1;
    
    ContactButton.layer.cornerRadius = 5;
    
    ConfirmButton.layer.cornerRadius = 5;
    
    [ContactButton setTitle:@"联系客服查询" forState:UIControlStateNormal];
    
    [ConfirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
    
    [ContactButton setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    
    [self.view addSubview:ConfirmButton];
    
    [self.view addSubview:ContactButton];
    //s设置2个按钮平分的约束
    [ContactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        make.left.equalTo(self.view).mas_offset(4);
        make.width.offset(kScreenWidth /2);
        make.height.offset(42);
        make.right.equalTo(ConfirmButton.mas_left).mas_offset(-4);
    }];
    [ConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        //          make.left.equalTo(CancelButton.mas_right).offset(-10);
        make.right.equalTo(self.view).mas_offset(-4);
        make.width.equalTo(ContactButton.mas_width);
        make.height.offset(42);
    }];
}

-(void)ContactButton:(UIButton *)sender{
    
}

-(void)ConfirmButton:(UIButton *)sender{
    
}
@end
