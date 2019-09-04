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
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *mData;
@property (nonatomic, strong) NSIndexPath *lastIndex;

@property (nonatomic, strong) UIButton *changeButton;
@end

@implementation CLHistorySelectionOfPayee

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择收款人";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];

    [self LoadCellType:10];
    
    self.mData=@[@"ang",@"ang",@"ang"];
    //以下为按钮
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
    
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLHistorySelctOfPayeeView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[CLHistorySelctOfPayeeView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
    [cell mCellStyle:1];
//    if(indexPath.row == self.lastIndex.row){
//        [cell mCellStyle:0];
//    }else
//        [cell mCellStyle:1];
    if(indexPath.row ==self.lastIndex.row){
        [cell mCellStyle:0];
    }
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lastIndex=indexPath;
    [self.mTabView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *mbgView = [UIView new];
    mbgView.backgroundColor = ssRGBHex(0xF6F5FA);
    mbgView.frame = CGRectMake(0, 0,kScreenWidth , 45);
    UIView *mButtonView = [UIView new];
    mButtonView.backgroundColor = ssRGBHex(0xFFFFFF);
    mButtonView.layer.cornerRadius = 4;
    mButtonView.layer.borderWidth = 1;
    mButtonView.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    [mbgView addSubview:mButtonView];
    
    
    UIButton *addButton = [[UIButton alloc] init];
//                           WithFrame:CGRectMake(50, 0, mButtonView.frame.size.width, mButtonView.frame.size.height)];
    [addButton setTitle:@"添加新收款人" forState:UIControlStateNormal];
    [addButton setImage:[UIImage yh_imageNamed:@"pdf_home_selectPayee_add_icon"] forState:UIControlStateNormal];
    [addButton setTitleColor:kCommonColor(140, 144, 145, 1) forState:UIControlStateNormal];
    addButton.titleLabel.font = kCommonFont(14);
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    
    [mButtonView addSubview:addButton];
    
//
    [mButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mbgView).mas_offset(15);
        make.right.equalTo(mbgView).mas_offset(-15);
        make.height.offset(44);
        make.top.equalTo(mbgView).offset(10);
    }];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mButtonView);
        make.height.equalTo(mButtonView.mas_height);
        make.width.equalTo(mButtonView.mas_width);
        
    }];
    return mbgView;
}
//
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 54;
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
        
        [self.DataSource removeAllObjects];
        [self hiddenLoading];
        if (success) {
            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"recipients"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [mResponse objectForKey:@"recipients"]) {
                    WKResipientInfoObj *mRefundAcc = [WKResipientInfoObj yy_modelWithDictionary:dic];
                    [self.DataSource addObject:mRefundAcc];
                }
            }
            
        }else{
            TOASTMESSAGE(result);
        }
        [self.myTableView reloadData];
    }];
}


-(void)SureBUtton:(UIButton *)sender{
    
    //确认按钮的点击事件
    [self CLNavBackAction];
    
}

@end
