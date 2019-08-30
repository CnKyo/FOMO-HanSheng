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
@end

@implementation CLHistoryRemittancePlan

- (void)viewDidLoad {
    [super viewDidLoad];
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mMo = [CLNavgationView_button shareDefaultNavRightButton];
    model.mRightView = mMo  ;
    mMo.mRightBtnBlock = ^(NSInteger tag) {
        if (tag == 1) {
            DebugLog(@"点击了按钮");
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
    [self LoadButton];
    [self ResetLayout];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
    return self.mData.count;
    }else{
        return 2;
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
        if(indexPath.row == 0){
            cell.mLeftName.text= @"汇款进度";
            cell.mRightData.text = @"";
             cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        }else{
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            cell.mLeftName.text= @"";
            cell.mRightData.text = @"";
            UILabel *mTime = [UILabel new];
            mTime.text = @"6月8号";
            mTime.font = [UIFont fontWithName:@"PingFangSC-Regular"size:14];
            mTime.textColor = ssRGBHex(0x8C9091);
            [cell.contentView addSubview:mTime];
            [mTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(14);
            }];
            _StepProgress = [[CLHistoryRenittabcePlanView alloc]initsetCount:4];
            [cell.contentView addSubview:_StepProgress];
            [_StepProgress mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(mTime.mas_bottom).offset(14);
                make.left.equalTo(cell).offset(64);
                make.height.offset(187);
                make.width.offset(10);
            }];
        }
      
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
    return 62;
    }else if(indexPath.section == 1 && indexPath.row ==0){
        return 62;
        
    }else{
        return 250;
    }
}

-(void)LoadButton{
    UIButton *CancelButton = [[UIButton alloc]init];
    
    UIButton *QueryButton = [[UIButton alloc]init];
    [CancelButton addTarget:self action:@selector(last:) forControlEvents:UIControlEventTouchUpInside];
    
    [QueryButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    
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

-(void)last:(UIButton *)sender{
    [self.StepProgress lastStep];
    
}

-(void)next:(UIButton *)sender{
    [self.StepProgress nextStep];
}
@end
