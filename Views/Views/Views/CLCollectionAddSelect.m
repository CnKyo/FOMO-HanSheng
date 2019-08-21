//
//  CLCollectionAddSelect.m
//  FOMOPay
//
//  Created by clkj on 2019/8/20.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionAddSelect.h"

@interface CLCollectionAddSelect ()<UITableViewDataSource,UITableViewDelegate>
/// 列表数据
@property (nonatomic) NSInteger mHeight;
@property (nonatomic) NSInteger i;
@end
//初始化数据
@implementation CLCollectionAddSelect
- (void)initWithModelArray:(NSArray *)modelLeftArray and:(NSInteger)i{
    self.mAddLeftDateSource = modelLeftArray;
    self.i = i;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadCellType:7];
    self.view.backgroundColor = [UIColor redColor];
    DebugLog(@"www%@",self.modelArray);
    self.mHeight = (self.modelArray.count) *44;
    DebugLog(@"那么他的高就是%ld",_mHeight);
    self.view.backgroundColor = ssRGBAlpha(120, 120, 122, 0.5);
    self.mTabView.backgroundColor = ssRGBAlpha(120, 120, 122, 0.5);
  
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.offset(self.mHeight + 44);
        make.bottom.equalTo(self.view).offset( -  BottomHeight);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     CLCollectionAddSelectTableView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.mSelectLable.text = [self.modelArray objectAtIndex:indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *mheadView = [UIView new];
    mheadView.backgroundColor = ssRGBHex(0xF2F2F2);
    UILabel *mCenterLable = [UILabel new];
    mCenterLable.text =[_mAddLeftDateSource objectAtIndex:self.i];
    [mheadView addSubview:mCenterLable];
    UIButton * mLeftButton = [UIButton new];
    UIButton *mRightButton = [UIButton new];
    mLeftButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    mRightButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [mLeftButton setTitle:@"取消" forState:UIControlStateNormal];
    [mLeftButton addTarget:self action:@selector(CloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [mRightButton setTitle:@"确定" forState:UIControlStateNormal];
    [mLeftButton setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    [mRightButton setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
    [mheadView addSubview:mLeftButton];
    [mheadView addSubview:mRightButton];
    [mCenterLable mas_makeConstraints:^(MASConstraintMaker *make) {
       make.center.equalTo(mheadView);
       
    }];
    [mLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mheadView).offset(15);
        make.centerY.equalTo(mCenterLable);
        
    }];
    
    [mRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mheadView).offset(-15);
        make.centerY.equalTo(mCenterLable);
        
        
    }];
    return mheadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  44;
}

-(void)CloseButton:(id)sender{
    DebugLog(@"点击了取消按钮即将实现取消操作");
    [self.view removeFromSuperview];
    self.view.userInteractionEnabled=TRUE;
}
@end
