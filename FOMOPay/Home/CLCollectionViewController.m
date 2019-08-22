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
@property (nonatomic,strong)  NSString *mPushData;
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
    [cell.CLCollectionDelete addTarget:self action:@selector(mDelete:) forControlEvents:UIControlEventTouchUpInside];
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
//- (void)initWithModelData:(NSString *)modelLeftArray{
//    _mPushData = modelLeftArray;
//    NSLog(@"传输过来的值为%@",self.mPushData);
//
////    UIImageView *mImg = [UIImageView new];
//    
////        [self performSelector:@selector(showAlter) withObject:nil afterDelay:1.5];
////       [self showAlter];
//
//}

-(void)showAlter{
    DebugLog(@"调用showAlter的值为%@",self.mPushData);
    UIImageView *mImg = [UIImageView new];
    mImg.image = [UIImage yh_imageNamed:@"pdf_collection_hint.pdf"];
    [self.view addSubview:mImg];
    [mImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    //设置动画
    CATransition * transion = [CATransition animation];
    
    transion.type = @"push";//设置动画方式
    transion.subtype = @"fromRight";//设置动画从那个方向开始
    //    [label.layer addAnimation:transion forKey:nil];//给Label.layer 添加动画 //设置延时效果
    [mImg.layer addAnimation:transion forKey:nil];
    //不占用主线程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [mImg removeFromSuperview];
    });
}

-(void)mDelete:(id)sender{
    DebugLog(@"点击了删除按钮");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除收款人" message:@"是否要删除此收款人" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *NoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    UIAlertAction *YesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [NoAction setValue:ssRGBHex(0x8C9091) forKey:@"titleTextColor"];
    [alertController addAction:NoAction];
    [alertController addAction:YesAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
