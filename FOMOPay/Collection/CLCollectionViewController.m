//
//  CLCollectionViewController.m
//  FOMOPay
//
//  Created by Lever on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionViewController.h"

@interface CLCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

//,CLCollectionAddDelegate>//代理传值用的代理
@property (nonatomic, strong) NSMutableArray * sectionArr;
@property (nonatomic, strong) NSMutableArray * boolArr;
@property (nonatomic, strong) NSIndexPath * mIdx;
@property (nonatomic, strong) NSMutableArray * mSecArr;


@end

@implementation CLCollectionViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self mHeaderLoadData];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    self.mSecArr = [NSMutableArray new];
    
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mBtView = [CLNavgationView_button shareDefaultNavRightButtonOther];
    model.mRightView = mBtView  ;
    mBtView.mRightBtnBlock = ^(NSInteger tag) {
        if(tag == 100){
            CLCollectionAdd *vc = [CLCollectionAdd new];
//          
            vc.mBackBlock = ^(BOOL success) {
                if (success) {
                    [weakSelf mHeaderLoadData];
                }
            };
            [self pushToViewController:vc];
        }
    };
    [self CLAddNavType:CLNavType_home andModel:model completion:^(NSInteger tag) {
        
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
    
    [self LoadCellType:4];
    
    self.mTabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJRefreshFastAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
            [weakSelf mHeaderLoadData];
            // 结束刷新
            [weakSelf.mTabView.mj_header endRefreshing];
        });
    }];
    
    [self mHeaderLoadData];
    
}
- (void)mHeaderLoadData {
    self.mPage--;
    if (self.mPage<=1) {
        self.mPage = 1;
    }
    [self showLoading:nil];
    [WKNetWorkManager WKGetRecipient:@{@"skip":[NSString stringWithFormat:@"%ld",self.mPage],@"take":@"150"} block:^(id result, BOOL success) {
        
        [self.mSecArr removeAllObjects];
        [self hiddenLoading];
        if (success) {
            NSMutableArray *mTempArr = [NSMutableArray new];

            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"recipients"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in [mResponse objectForKey:@"recipients"]) {
                    WKResipientInfoObj *mRefundAcc = [WKResipientInfoObj yy_modelWithDictionary:dic];
                    [mTempArr addObject:mRefundAcc];
                }
            }
            [self.mSecArr addObjectsFromArray:mTempArr];

        }else{
            TOASTMESSAGE(result);
        }
        [self semboldData];
    }];
}

- (void)semboldData{
    [self.DataSource removeAllObjects];
    [self.sectionArr removeAllObjects];
    for (WKResipientInfoObj *obj in self.mSecArr) {
        [self.sectionArr addObject:obj.currencyCode];
    }
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSString *item in self.sectionArr) {
        if (![resultArray containsObject:item]) {
            [resultArray addObject:item];
        }
    }
    [self.sectionArr removeAllObjects];
    [self.sectionArr addObjectsFromArray:resultArray];
    [self.boolArr removeAllObjects];
     for (int i = 0; i < resultArray.count ; i++) {   // 0<2;//判断有几个分组
        
        NSString *mCode = resultArray[i];
        NSMutableArray * friendArr = [[NSMutableArray alloc] init];
        for (int j = 0; j < self.mSecArr.count ;j++) {
          
            WKResipientInfoObj *mItem = self.mSecArr[j];
            if ([mCode isEqualToString:mItem.currencyCode]) {
                [friendArr addObject:mItem];
            }
        }
        [self.DataSource addObject:friendArr];
        [self.sectionArr addObject:mCode];
        [self.boolArr addObject:@YES];
    }
    
    [self.mTabView reloadData];
    
}
- (void)makeConstraintsForUI {
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.DataSource.count;//有几组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.boolArr[section] boolValue] == NO) {
        
        return 0;
    }else {
        
        return [self.DataSource[section] count];  ////////每组有多少个
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    CLCollectionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    [cell CellStyle:2];
    NSArray *mArr = self.DataSource[indexPath.section];
    WKResipientInfoObj *mItem = mArr[indexPath.row];
    
    [cell setMItem:mItem];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mInd = indexPath;
    cell.mDeleteBlock = ^(NSIndexPath * _Nonnull mIndex) {
        weakSelf.mIdx = mIndex;
        [weakSelf mDelete:mIndex];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //创建header的view
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.backgroundColor = ssRGBHex(0xF6F5FA);
    headerView.tag = 2019 + section;
    //添加imageview
    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-40, 22, 12 , 7)];
    
    //三目运算选择展开或者闭合时候的图标
    iv.image = [_boolArr[section] boolValue] ?
    [UIImage yh_imageNamed:@"pdf_collection_shrink.pdf"] :
    [UIImage yh_imageNamed:@"pdf_collection_unfold.pdf"];
    [headerView addSubview:iv];
    
    //添加标题label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, self.view.frame.size.width - 100, 50)];
    label.text = self.sectionArr[section];
    //    DebugLog(@"self.sectionArr[section]%@",self.sectionArr[section]);
    [headerView addSubview:label];
    
    
    //添加轻扣手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 108;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section != self.DataSource.count -1){
        UIView *mLineView = [UIView new];
        mLineView.backgroundColor  = ssRGBHex(0xF6F5FA);
        UIView *aview = [UIView new];
        aview.backgroundColor  = ssRGBHex(0xCCCCCC);
        [mLineView addSubview:aview];
        [aview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(mLineView).offset(0);
            make.height.offset(1);
            make.width.offset(kScreenWidth);
        }];
        return mLineView;
    }else{
        return nil;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == self.DataSource.count -1 ){
        return 0.001;
    }else{
        return 11;
    }
    
}
#pragma mark - action
- (void)tapGR:(UITapGestureRecognizer *)tapGR {
    
    //获取section
    NSInteger section = tapGR.view.tag - 2019;
    //判断改变bool值
    if ([_boolArr[section] boolValue] == YES) {
        [_boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [_boolArr replaceObjectAtIndex:section withObject:@YES];
    }
    //刷新某个section
    [self.mTabView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}


- (NSMutableArray *)sectionArr {
    
    if (!_sectionArr) {
        
        _sectionArr = [[NSMutableArray alloc] init];
    }
    return _sectionArr;
}

- (NSMutableArray *)boolArr {
    
    if (!_boolArr) {
        
        _boolArr = [[NSMutableArray alloc] init];
    }
    return _boolArr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DebugLog(@"点击了列表进入修改");
   
    CLCollectionAlter *vc = [CLCollectionAlter new];
    NSArray *mSection = self.DataSource[indexPath.section];
    vc.mData = mSection[indexPath.row];
    [self pushToViewController:vc];

}

-(void)mDelete:(NSIndexPath *)indexPath{
    
    DebugLog(@"点击了删除按钮");
    DebugLog(@"当前行%@",self.mIdx);
    DebugLog(@"当前组%ld",(long)self.mIdx.section);
    DebugLog(@"当前行%ld",(long)self.mIdx.row);
    __block typeof(self) WeakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除收款人" message:@"是否要删除此收款人" preferredStyle:UIAlertControllerStyleAlert];
    __block  UIAlertAction *NoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    __block UIAlertAction *YesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        NSArray *mSection = self.DataSource[indexPath.section];
        WKResipientInfoObj *mItem = mSection[indexPath.row];
        [WeakSelf deleteAction:mItem];
        [WeakSelf.mTabView reloadData];
        
    }];
    [NoAction setValue:ssRGBHex(0x8C9091) forKey:@"titleTextColor"];
    [alertController addAction:NoAction];
    [alertController addAction:YesAction];
    
    [WeakSelf presentViewController:alertController animated:YES completion:nil];
}
- (void)deleteAction:(WKResipientInfoObj *)item{
    
    [self showLoading:nil];
    [WKNetWorkManager WKDeleteRecipient:item.id block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            [SVStatusHUD showWithImage:[UIImage yh_imageNamed:@"pdf_info_success"] status:languageStr(@"Delete")];
//            TOASTMESSAGE(@"Delete Success!");
            NSArray *mSection = self.DataSource[self.mIdx.section];
            
//            [self.DataSource removeObjectAtIndex:self.mIdx.row];
            [self.DataSource removeObject:mSection[self.mIdx.row]];
            [self mHeaderLoadData];
            [self.mTabView reloadData ]; //
//            [self.DataSource removeAllObjects];
            
            
        }else{
            TOASTMESSAGE(result);
        }
    }];
    
}



@end
