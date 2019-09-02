//
//  CLHistoryRemittancePlan.m
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRemittancePlan.h"

@interface CLHistoryRemittancePlan ()<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,strong)CLHistoryRenittabcePlanView *StepProgressPortrait;


@property (nonatomic,strong)NSArray *mData;
@property (nonatomic,strong)NSArray *mRData;
@property (nonatomic,strong)CLHistoryRenittabcePlanView *StepProgress;
@property NSInteger i;
@property (nonatomic,strong)NSArray *mLeftDate;//左边的日期
@property (nonatomic,strong)NSArray *mRightData;
@property (nonatomic,strong)NSArray *mRightDataHint;
@end

@implementation CLHistoryRemittancePlan

- (void)viewDidLoad {
    [super viewDidLoad];
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mMo = [CLNavgationView_button shareDefaultNavRightButton];
    model.mRightView = mMo  ;
    mMo.mRightBtnBlock = ^(NSInteger tag) {
        if (tag == 1) {
            
            CLHistoryDetailsOfRemittances *vc = [CLHistoryDetailsOfRemittances new];
            [self pushToViewController: vc];
            
        }
    };
    self.title = @"汇款进度";
    [self CLAddNavType:CLNavType_default andModel:model completion:^(NSInteger tag) {
        
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
     self.mData=@[@"收款人",@"汇款金额",@"获得金额"];
    self.mRData=@[@"Angela Lee",@"SGD182.00",@"CNY910.00"];
    self.mLeftDate = @[@"7月7日",@"7月8日",@"7月9日",@"7月30日"];
    self.mRightData = @[@"提交汇款订单",@"已收到您的付款",@"汇款处理中",@"汇款成功"];
    self.mRightDataHint =@[@"等待付款中，请使用本人账户进行付款。如果您已经完成支付，请耐心等待，我们需要时间核对付款讯息，谢谢！",
                           @"款项核对中...",@"您的汇款将在今日内处理完毕,稍后将会有短信提示",@"汇款成功"];
    
    self.i=4;  //控制进度条1-4。 取值1-4;

//    [self LoadButton];
    [self ResetLayout];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
    return self.mData.count;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLHistoryDetailsOfRemittancesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[CLHistoryDetailsOfRemittancesCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
     cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    if(indexPath.section == 0){
   
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
    if(indexPath.row == 2){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    cell.mLeftName.text= [_mData objectAtIndex:indexPath.row];
    cell.mLeftName.textAlignment = NSTextAlignmentLeft;
    cell.mRightData.text = [_mRData objectAtIndex:indexPath.row];
    cell.mRightData.textAlignment = NSTextAlignmentRight;
       
    }

    if(indexPath.section == 1){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        cell.mRightData.hidden = YES;
        cell.mLeftName.font = kCommonFont(14);
        if(indexPath.row == 0){
            cell.mLeftName.text = @"汇款进度";
            cell.mLeftName.font = kCommonFont(16);
            
            }
        
        if(indexPath.row == 1){
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 112)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
    
                [bgview addSubview:titleLabel];
                UILabel  *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 20, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.font = kCommonFont(16);
                mLabel.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel];
                
                UILabel *mTitleHint = [[UILabel alloc]initWithFrame:CGRectMake(97, 38, 256, 57)];//提示小文字
                mTitleHint.textColor = ssRGBHex(0x8C9091);
                mTitleHint.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint.numberOfLines = 0;
                mTitleHint.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint];
                
                [self LoadButtonCancelAndQuery];
            }else if(self.i >indexPath.row){
                cell.mLeftName.text =[_mLeftDate objectAtIndex:indexPath.row - 1];
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 48)];//背景条
                bgview.backgroundColor =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }}
      //第二个
        if(indexPath.row == 2){
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(15, 16, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 106)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, -5, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                
                [bgview addSubview:titleLabel];
                UILabel  *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 14, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.font = kCommonFont(16);
                mLabel.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel];
                
                UILabel *mTitleHint = [[UILabel alloc]initWithFrame:CGRectMake(97, 25, 256, 57)];//提示小文字
                mTitleHint.textColor = ssRGBHex(0x8C9091);
                mTitleHint.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint.numberOfLines = 0;
                mTitleHint.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint];
                
                
            }else if(self.i >indexPath.row){
                cell.mLeftName.text =[_mLeftDate objectAtIndex:indexPath.row - 1];
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 48)];//背景条
                bgview.backgroundColor =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }else{
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 41)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0xE6E6E6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }}
        //第三个
        if(indexPath.row == 3){
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(15, 16, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 82)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, -5, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                
                [bgview addSubview:titleLabel];
                UILabel  *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 16, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.font = kCommonFont(16);
                mLabel.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel];
                
                UILabel *mTitleHint = [[UILabel alloc]initWithFrame:CGRectMake(97, 24, 256, 57)];//提示小文字
                mTitleHint.textColor = ssRGBHex(0x8C9091);
                mTitleHint.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint.numberOfLines = 0;
                mTitleHint.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint];
                
                [self LoadContactButton];
               
            }else if(self.i >indexPath.row){
                cell.mLeftName.text =[_mLeftDate objectAtIndex:indexPath.row - 1];
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 47)];//背景条
                bgview.backgroundColor =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }else{
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 41)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0xE6E6E6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }}
        
        
        //第四个
        if(indexPath.row == 4){
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(13, 20, 60, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 0)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                
                [bgview addSubview:titleLabel];
                UILabel  *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 16, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.font = kCommonFont(16);
                mLabel.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel];
                if([mLabel.text isEqual:@"汇款成功"]){
                    DebugLog(@"w231232");
                    [self LoadAlterButton];
                };
                
                UILabel *mTitleHint = [[UILabel alloc]initWithFrame:CGRectMake(97, 27, 256, 57)];//提示小文字
                mTitleHint.textColor = ssRGBHex(0x8C9091);
                mTitleHint.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint.numberOfLines = 0;
                mTitleHint.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint];
                
               
//            }else if(self.i >indexPath.row){
//                cell.mLeftName.text =[_mLeftDate objectAtIndex:indexPath.row - 1];
//                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 39)];//背景条
//                bgview.backgroundColor =ssRGBHex(0x005CB6);
//                [cell.contentView addSubview:bgview];
//                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
//                titleLabel.backgroundColor = ssRGBHex(0x005CB6);
//                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
//                titleLabel.layer.cornerRadius = 10/2 ;
//                titleLabel.clipsToBounds = YES ;
//                [bgview addSubview:titleLabel];
//                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
//                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
//                mLabel.textColor =  ssRGBHex(0x8C9091);
//                mLabel.font = kCommonFont(16);
//                [cell.contentView addSubview:mLabel];
            }else{
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 0)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0xE6E6E6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }}
        if(indexPath.row == 5){
            cell.mLeftName.hidden = YES;
            cell.mRightData.hidden = YES;
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
    return 62;
    }else if(indexPath.section == 1 && indexPath.row ==0){
        return 62;
    }
    if(indexPath.section ==1 &&indexPath.row==1 &&self.i==1){
        return 118;
    }else if(indexPath.section ==1 &&indexPath.row==2 &&self.i==2){
        return 41+23;
    }else if(indexPath.section ==1 &&indexPath.row==3 &&self.i==3){
        return 41+38+8;
    }else{
        return 41;
    }
}


//-------------------------第一组按钮以及他的点击事件
-(void)LoadButtonCancelAndQuery{
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
    __block typeof(self) WeakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消汇款" message:@"是否要取消本次汇款" preferredStyle:UIAlertControllerStyleAlert];
    __block  UIAlertAction *NoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    __block UIAlertAction *YesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if(YesAction){
            CLHistoryCancelRemittance *vc = [CLHistoryCancelRemittance new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    [NoAction setValue:ssRGBHex(0x8C9091) forKey:@"titleTextColor"];
    [alertController addAction:NoAction];
    [alertController addAction:YesAction];
    
    [WeakSelf presentViewController:alertController animated:YES completion:nil];
}

-(void)QueryButton:(UIButton *)sender{
    DebugLog(@"点击了查询");
    CLHistoryPaymentdetails *vc = [CLHistoryPaymentdetails new];
    [self pushToViewController:vc];
}

//-------------------------第二组按钮以及他的点击事件
-(void)LoadContactButton{
    UIButton *ContactButton = [UIButton new];
    ContactButton.backgroundColor = ssRGBHex(0xF6F5FA);
    
    [ContactButton setTitle:@"联系客服" forState:UIControlStateNormal];
    
    ContactButton.layer.borderColor = ssRGBHex(0x005CB6).CGColor;
    
    ContactButton.layer.borderWidth = 1;
    
    ContactButton.layer.cornerRadius = 5;
    [ContactButton setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    
    [ContactButton.titleLabel setFont:[UIFont fontWithName:@"RazerF5" size:15]];
    
    [ContactButton addTarget:self action:@selector(Call:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ContactButton];
    [ContactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(4);
        make.right.equalTo(self.view).offset(-4);
        make.height.offset(42);
        make.width.offset(kScreenWidth);
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
    }];
}

-(void)Call:(UIButton *)sender{
   
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-000-0000"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-000-0000"]  options:@{} completionHandler:nil];
}

//------------------------汇款失败的时候的修改按钮以及他的点击事件
-(void)LoadAlterButton{
    UIButton *AlterButton = [UIButton new];
    AlterButton.backgroundColor = ssRGBHex(0x005CB6);
    [AlterButton setTitle:@"修改" forState:UIControlStateNormal];
    AlterButton.layer.cornerRadius = 5;
    [AlterButton setTitleColor:ssRGBHex(0xFFFFFF) forState:UIControlStateNormal];
    AlterButton.titleLabel.font =kCommonFont(14);
    [AlterButton addTarget:self action:@selector(Alter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AlterButton];
    [AlterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset( - BottomHeight - 10  );
        make.height.offset(42);
        make.width.offset(kScreenWidth);
    }];
}

-(void)Alter:(UIButton *)sender{
    CLHistoryAlterRemittance *vc = [CLHistoryAlterRemittance new];
    [self pushToViewController:vc];
}
@end
