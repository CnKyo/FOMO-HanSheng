//
//  CLHistoryAlterRemittance.m
//  FOMOPay
//
//  Created by clkj on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryAlterRemittance.h"
#import "CLHistorySelectionOfPayee.h"
@interface CLHistoryAlterRemittance ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)NSArray *mData;
@property (nonatomic,strong)NSArray *mTopData;
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
            CLHistoryConfirmRefund *vc=[CLHistoryConfirmRefund new];
            [self pushToViewController:vc];
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
    self.mData=@[@"无效的账号:",@"订单号",@"全名",@"银行",@"分行",@"账户号码"];
    self.mTopData = @[@"汇款金额",@"获得金额",@"汇率"];
    [self LoadContactAndConfirm];
   [self ResetLayout];  //底部按钮适配5s的约束
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
    return self.mData.count;
    }else{
        return 3;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLHistoryDetailsOfRemittancesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[CLHistoryDetailsOfRemittancesCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
    if(indexPath.section ==0){
        cell.mLeftName.text = [self.mData objectAtIndex:indexPath.row];
        if(indexPath.row == 0){
            cell.mLeftName.textColor = ssRGBHex(0xD50037);
        }
        if(indexPath.row == 1){
             cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        }else if(indexPath.row ==2 ||indexPath.row ==3 ||indexPath.row==4){
             cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        }else if(indexPath.row ==5){
            cell.mRightData.hidden = YES;
            UITextField *mTextF = [UITextField new];
            mTextF.textAlignment = NSTextAlignmentRight;
            mTextF.font = kCommonFont(14);
            mTextF.clearButtonMode =UITextFieldViewModeAlways;
            mTextF.delegate = self;
            mTextF.returnKeyType = UIReturnKeyDone;
            mTextF.placeholder = @"请输入账户号码";
            [cell.contentView addSubview:mTextF];
            [mTextF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).offset(-10.5);
                make.centerY.equalTo(cell.mLeftName);
            }];
        }
        
    }
    if(indexPath.section == 1){
        cell.mLeftName.text =[self.mTopData objectAtIndex:indexPath.row];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
    }
//    if(indexPath.row == 0){
//        cell.mLeftName.text = @"无效的账号:";
//        cell.mLeftName.textColor = ssRGBHex(0xD50037);
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        cell.mRightData.text = @"请更正账户号码或者更换汇款账号";
//        cell.mRightData.textAlignment = NSTextAlignmentLeft;
//    }else{
//        cell.mLeftName.text = [self.mData objectAtIndex:indexPath.row];
//
////    }else if(indexPath.row == 2){
////        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
////    }else if(indexPath.row == 6){
////        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
////    }else if(indexPath.row == 8){
////        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
////    }
//
////    cell.mLeftName.text= [_mData objectAtIndex:indexPath.row];
////    cell.mLeftName.textAlignment = NSTextAlignmentLeft;
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 &&indexPath.section == 0){
        return 41;
    }
   
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 0){
        UIView *mView = [UIView new];
        mView.backgroundColor = ssRGBHex(0xFFFFFF);
        UIView *mTopLine = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth, 1)];
        mTopLine.backgroundColor = ssRGBHex(0x005CB6);
        [mView addSubview:mTopLine];
        UIView *mBtview = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
        mBtview.backgroundColor = ssRGBHex(0xCCCCCC);
        [mView addSubview: mBtview];
        UIButton *mReplace = [UIButton new];
        [mReplace setTitle:@"更换账号" forState:UIControlStateNormal];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"更换账号"];
        
        [attri addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:NSMakeRange(0, 4)];
        [attri addAttribute:NSForegroundColorAttributeName value:ssRGBHex(0x005CB6) range:NSMakeRange(0, 4)];
        [attri addAttribute:NSUndefinedKeyException value:ssRGBHex(0x005CB6) range:NSMakeRange(0, 4)];
        [mReplace setAttributedTitle:attri forState:UIControlStateNormal];
        [mReplace setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
        mReplace.titleLabel.font = kCommonFont(14);
        [mReplace addTarget:self action:@selector(ReplaceAccount:) forControlEvents:UIControlEventTouchUpInside];
        [mView addSubview:mReplace];
        [mReplace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(mView).offset(-15);
            make.top.equalTo(mView).offset(13);
            make.height.offset(14);
        }];
        return mView;
    }else{
        UIView *mBtView = [UIView new];
        mBtView.backgroundColor = ssRGBHex(0xCCCCCC);
        return mBtView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 39;
    }else{
    return 1;
    }}




////---------=======================-----===========-=---------------Text的代理
-(void)textFieldDidEndEditing:(UITextField *)textField{
   
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
  
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
  
        // 每间隔4个字符插入一个空格并在删除时去掉
        NSMutableString *strmText = [NSMutableString stringWithString:textField.text];
        if ([textField.text length] == range.location) {
            
            // 插入
            if ([textField.text length]%5 == 4) {
                
                [strmText appendString:@" "];
            }
            
        } else {
            
            // 删除
            if ([textField.text length] && [textField.text length]%5 == 0) {
                
                strmText = [NSMutableString stringWithString:[strmText substringToIndex:strmText.length - 1]];
            }
        }
        
        textField.text = strmText;
    
    return YES;
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


///---------------更换账号的点击事件
-(void)ReplaceAccount:(UIButton *)sender{
    CLHistorySelectionOfPayee *vc = [CLHistorySelectionOfPayee new];
    [self pushToViewController:vc];
}
@end
