//
//  CLCollectionViewController.m
//  FOMOPay
//
//  Created by Lever on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionViewController.h"

@interface CLCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * sectionArr;
@property (nonatomic, strong) NSMutableArray * boolArr;
@end

@implementation CLCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn= [UIButton new];
        [btn setTitle:@"添加" forState:UIControlStateNormal];
        [btn setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        UIView *mView = [UIView new];
        [mView addSubview:btn];
    [btn addTarget:self action:@selector(Add:) forControlEvents:UIControlEventTouchUpInside];

        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(mView).offset(-20);
            make.top.equalTo(mView).offset(0);
            make.bottom.equalTo(mView).offset(0);
        }];
    CLNavModel *model = [CLNavModel new];
    model.mRightView = mView  ;
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
    [self loadData];
//
    [self LoadCellType:4];
//    [self makeConstraintsForUI];
    // Do any additional setup after loading the view.
}
- (void)loadData {
    
    NSArray * secArr = @[@"CNY", @"MYR"];
    NSArray * rowsArr = @[@(12),@(10)];
    
    for (int i = 0; i < secArr.count; i++) {
        
        NSMutableArray * friendArr = [[NSMutableArray alloc] init];
        for (int j = 0; j < 2 ;j++) {
            
            [friendArr addObject:@(j)];
        }
        [self.DataSource addObject:friendArr];
        [self.sectionArr addObject:secArr[i]];
        [self.boolArr addObject:@NO];
    }
}
- (void)makeConstraintsForUI {
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.DataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.boolArr[section] boolValue] == NO) {
        
        return 0;
    }else {
        
        return [self.DataSource[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLCollectionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //  自定义填充数据的地方
    [cell CellStyle:2];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //创建header的view
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
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
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 11;
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

-(void)Add:(id)sender{
    DebugLog(@"点击了按钮吧");
    CLCollectionAdd *vc = [CLCollectionAdd new];
    [self pushToViewController:vc];
}
@end
