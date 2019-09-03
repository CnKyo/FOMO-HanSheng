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
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSIndexPath *lastIndex;

@property (nonatomic, strong) UIButton *changeButton;
@end

@implementation CLHistorySelectionOfPayee

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择收款人";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    [self loadTableView];
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
- (void)loadTableView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 44)];
//                          Frame:CGRectMake(0, 10, kScreenWidth, 44)];
    footerView.backgroundColor =[UIColor clearColor];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, footerView.frame.size.width - 20, footerView.frame.size.height)];
    [addButton setTitle:@"添加新收款人" forState:UIControlStateNormal];
    [addButton setImage:[UIImage yh_imageNamed:@"pdf_home_selectPayee_add_icon"] forState:UIControlStateNormal];
    [addButton setTitleColor:kCommonColor(140, 144, 145, 1) forState:UIControlStateNormal];
    addButton.titleLabel.font = kCommonFont(14);
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [footerView addSubview:addButton];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(- BottomHeight - 10 - 44);
//        make.bottom.equalTo(self.view).offset(-kBottomToolBarHeight - 10);
        make.top.equalTo(self.view).offset(44 + kAppStatusBarHeight);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeSelectPayeeListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    UIView *mFtView = [UIView new];
//    mFtView.backgroundColor = [UIColor redColor];

    _myTableView.tableFooterView = footerView;
//     _myTableView.tableFooterView = mFtView;
    
    
  
   
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 98;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 8;
    }else{
    return 0.001;
}
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeSelectPayeeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[HomeSelectPayeeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeSelectPayeeListCell *lastCell = (HomeSelectPayeeListCell *)[tableView cellForRowAtIndexPath:_lastIndex];
    lastCell.bgImageView.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_bg_gray"];
    lastCell.selectImage.hidden = YES;
    
    HomeSelectPayeeListCell *currentCell = (HomeSelectPayeeListCell *)[tableView cellForRowAtIndexPath:indexPath];
    currentCell.bgImageView.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_bg_grren"];
    currentCell.selectImage.hidden = NO;
    
    _lastIndex = indexPath;
}



//////---------------按钮的点击事件
- (void)addButtonClicked{
    
    //添加收款人
}


-(void)SureBUtton:(UIButton *)sender{
    
    //确认按钮的点击事件
    
}

@end
