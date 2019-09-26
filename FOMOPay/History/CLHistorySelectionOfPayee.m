//
//  CLHistorySelectionOfPayee.m
//  FOMOPay
//
//  Created by clkj on 2019/9/3.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistorySelectionOfPayee.h"


#import "HomeSelectPayeeViewController.h"
#import "HomeSelectPayeeListCell.h"
#import "HomeSureInfoViewController.h"
#import "HomeChangePayeeVC.h"
@interface CLHistorySelectionOfPayee ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *mData;
@property (nonatomic, strong) NSIndexPath *lastIndex;

@property (nonatomic, strong) UIButton *changeButton;
@property (strong,nonatomic) WKResipientInfoObj *mItem;
@end

@implementation CLHistorySelectionOfPayee

- (NSMutableArray *)mData{
    if(!_mData){
        _mData = [NSMutableArray new];
    }
    return _mData;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择收款人";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];

    [self LoadCellType:10];
    self.mTabView.estimatedRowHeight = 0;
    self.mTabView.estimatedSectionFooterHeight = 0;
    self.mTabView.estimatedSectionHeaderHeight = 0; 
   

    [self LoadSureButton];
    [self loadData];
    
    
    /////
    UIView *mbgView = [UIView new];
    mbgView.backgroundColor = [UIColor clearColor];
    mbgView.frame = CGRectMake(0, 0,kScreenWidth , 55);
    UIView *mButtonView = [UIView new];
    mButtonView.backgroundColor = [UIColor clearColor];
    mButtonView.layer.cornerRadius = 4;
    mButtonView.layer.borderWidth = 1;
    mButtonView.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    [mbgView addSubview:mButtonView];
    
    
    UIButton *addButton = [[UIButton alloc] init];
    //                           WithFrame:CGRectMake(50, 0, mButtonView.frame.size.width, mButtonView.frame.size.height)];
    [addButton setTitle:@"添加新收款人" forState:UIControlStateNormal];
    [addButton setImage:[UIImage yh_imageNamed:@"pdf_home_selectPayee_add_icon"] forState:UIControlStateNormal];
    addButton.layer.cornerRadius = 4;
    [addButton setTitleColor:kCommonColor(140, 144, 145, 1) forState:UIControlStateNormal];
    addButton.titleLabel.font = kCommonFont(14);
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    
    [mButtonView addSubview:addButton];
    
    //
    [mButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mbgView).mas_offset(10);
        make.right.equalTo(mbgView).mas_offset(-10);
        make.height.offset(44);
        make.top.equalTo(mbgView).offset(10);
    }];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mButtonView);
        make.height.equalTo(mButtonView.mas_height);
        make.width.equalTo(mButtonView.mas_width);
        
    }];
    self.mTabView.tableFooterView = mbgView;
    [self ResetLayoutSelect];
    
}





-(void)LoadSureButton{
    UIButton *mSureButton = [UIButton new];
    [mSureButton setTitle:@"确认" forState:UIControlStateNormal];
    mSureButton.layer.cornerRadius  =4;
    mSureButton.backgroundColor = ssRGBHex(0x005CB6);
    mSureButton.titleLabel.font = kCommonFont(14);
    [mSureButton setTitleColor:ssRGBHex(0xFFFFFF) forState:UIControlStateNormal];
    [mSureButton addTarget:self action:@selector(SureBUtton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mSureButton];
    [mSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-BottomHeight - 10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.offset(44);
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLHistorySelctOfPayeeView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[CLHistorySelctOfPayeeView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
//    [cell mCellStyle:1];
//    if(indexPath.row == self.lastIndex.row){
//        [cell mCellStyle:0];
//    }else
//        [cell mCellStyle:1];
//    if (self.ifSelected) {
//        [cell mCellStyle:0];
//    }else{
//        [cell mCellStyle:1];
//    }
    
    [cell setMItem:self.mData[indexPath.row]];
//    DebugLog(@"2222%@",self.mData[indexPath.row]);
    if(self.mInx != nil && self.mInx.row == indexPath.row){
        [cell mCellStyle:0];
        self.mItem = self.mData[indexPath.row];
    }else{
        [cell mCellStyle:1];
    }
    DebugLog(@"%@",self.mItem);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSIndexPath * temp = self.lastIndex;//暂存上一次选中的行
//    if (temp && temp != indexPath)//如果上一次的选中的行存在,并且不是当前选中的这一行,则让上一行不选中
//    {
//        self.ifSelected = NO;//修改之前选中的cell的数据为不选中
//        [tableView reloadRowsAtIndexPaths:@[temp] withRowAnimation:UITableViewRowAnimationAutomatic];//刷新该行
//    }
//    self.lastIndex = indexPath;//选中的修改为当前行
//    self.ifSelected = YES;//修改这个被选中的一行
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        self.mItem = self.mData[indexPath.row];
    self.mInx = indexPath;
    [self.mTabView reloadData];
}


//////---------------按钮的点击事件
- (void)addButtonClicked{
    WS(weakSelf);
    
    CLCollectionAdd *vc = [CLCollectionAdd new];
    vc.mBackBlock = ^(BOOL success) {
        if (success) {
            [weakSelf loadData];
        }
    };
    [self pushToViewController:vc];
}


- (void)loadData{
    [self showLoading:nil];
    [WKNetWorkManager WKGetRecipient:@{@"skip":@"1",@"take":@"50"} block:^(id result, BOOL success) {
        [self.mData removeAllObjects];
        [self.DataSource removeAllObjects];
        [self hiddenLoading];
        if (success) {
            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"recipients"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [mResponse objectForKey:@"recipients"]) {
                    WKResipientInfoObj *mRefundAcc = [WKResipientInfoObj yy_modelWithDictionary:dic];
                    [self.mData addObject:mRefundAcc];
                }
            }
            
        }else{
            TOASTMESSAGE(result);
        }
        [self.mTabView reloadData];
    }];
}


-(void)SureBUtton:(UIButton *)sender{
    
    //确认按钮的点击事件
//    [self CLNavBackAction];
    if (self.mBlock) {
        self.mBlock(self.mItem);
    }
    [self popToViewController];
    
}

@end
