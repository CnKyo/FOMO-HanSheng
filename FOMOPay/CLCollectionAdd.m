//
//  CLCollectionAdd.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionAdd.h"

@interface CLCollectionAdd ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CLCollectionAddSelectDelegate>
@property (nonatomic,strong) NSArray *mAddLeftDateSource;
@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;
@property (nonatomic,strong) NSString *mModeString;
@property (nonatomic,strong) UILabel *mLabel;
@property (nonatomic,strong) UIImageView *mImageView ;
@property (nonatomic,strong) NSArray *modelArray;
@property (nonatomic,strong) NSIndexPath *mIndex;
@property (nonatomic,strong) UIButton *mSendButton;
@property (nonatomic,strong) NSMutableArray *mMdate;

@end

@implementation CLCollectionAdd

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加新收款人";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
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
    
    [self LoadCellType:6];
    self.mSendButton = [UIButton new];
    [self.mSendButton setTitle:@"提交" forState:UIControlStateNormal];
    self.mSendButton.backgroundColor = clBlueRGB;
    self.mSendButton.layer.cornerRadius = 4;
    [self.mSendButton addTarget:self action:@selector(successfullyadd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mSendButton];
    [self.mSendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(- BottomHeight - 10);
        make.height.offset(44);
        make.width.offset(kScreenWidth);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        }];
    
    self.mImageView = [UIImageView new];
    [self loadData];
}

- (void)loadData{
    _mAddLeftDateSource=@[@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"联系号码",@""];
    _modelArray = @[@[@"中国",@"马来西亚",@"菲律宾",@"越南",@"台湾",@"泰国",@"香港",@"新加坡",@"日本"],@[@"男",@"女"],@[@"DBS Bank Ltd",@"POSB国家储蓄银行",@"UOB大华银行",@"OCBC华侨银行"],@[@"本人",@"亲人",@"好友",@"同事"] ];
     _mModeString = @"请选择";
     self.mMdate  =  [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mAddLeftDateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 8) {
        return 34;
    }
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeLanguage *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLMeLanguage alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    cell.mMeLanguageLeftLabel.text = _mAddLeftDateSource[indexPath.row];
    if(indexPath.row == 0 ){
    cell.mIndexPath = indexPath;
    [cell updateView:CLMeLanguageType_textFiled and:nil];
    cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
        DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
         [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
        DebugLog(@"当前的text的值是%@",self.mMdate);
        
    };}
    
    if(indexPath.row == 1){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_button and:_mModeString];
        cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
//            NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
                    self.mSelectView = [CLCollectionAddSelect new];
                    self.mSelectView.delegate = self;//实现他的代理方法
                    self.mSelectView.modelArray  = [self.modelArray objectAtIndex:0];//把当前数据传入另一个j控制器的moderarrl里面;
                    [self.view addSubview:self.mSelectView.view];
                     [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
                    self.mIndex = indexPath;
    
        };}
        if(indexPath.row == 2){
            cell.mIndexPath = indexPath;
            [cell updateView:CLMeLanguageType_button and:_mModeString];
            cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {

                self.mSelectView = [CLCollectionAddSelect new];
                self.mSelectView.delegate = self;//实现他的代理方法
                self.mSelectView.modelArray  = [self.modelArray objectAtIndex:1];//把当前数据传入另一个j控制器的moderarrl里面;
                [self.view addSubview:self.mSelectView.view];
                [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
                 self.mIndex = indexPath;
            };}
    if(indexPath.row == 3){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_button and:_mModeString];
        cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
            
            self.mSelectView = [CLCollectionAddSelect new];
            self.mSelectView.delegate = self;//实现他的代理方法
            self.mSelectView.modelArray  = [self.modelArray objectAtIndex:2];//把当前数据传入另一个j控制器的moderarrl里面;
            [self.view addSubview:self.mSelectView.view];
            [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
            self.mIndex = indexPath;
        };}
  
    if(indexPath.row == 6){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_button and:_mModeString];
        cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
            self.mSelectView = [CLCollectionAddSelect new];
            self.mSelectView.delegate = self;//实现他的代理方法
            self.mSelectView.modelArray  = [self.modelArray objectAtIndex:3];//把当前数据传入另一个j控制器的moderarrl里面;
            [self.view addSubview:self.mSelectView.view];
            [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
            self.mIndex = indexPath;
        };}
    if(indexPath.row == 4 ){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_textFiled and:nil];
        cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
             [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
            
        };}
    
    
    if(indexPath.row == 5){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_textFiled and:nil];
        cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
             [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
            
        };
        
    }

    
    if(indexPath.row == 7){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_textFiled and:nil];
        cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
             [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
        };}

    
    if(indexPath.row == 8){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //在当前控制器添加子控制器的view的调用方法
//    if(indexPath.row == 1){
//        NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
//        self.mSelectView = [CLCollectionAddSelect new];
//        self.mSelectView.delegate = self;//实现他的代理方法
//        self.mSelectView.modelArray  = modelArray;//把当前数据传入另一个j控制器的moderarrl里面;
//      
//        [self.view addSubview:self.mSelectView.view];
//        
//        [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
//        }
//    }

//-(void)initWithModelString:(NSString *)modelString{
//    self.mModeString = modelString;
//    DebugLog(@"接受到传递过来的值为%@",self.mModeString);
//}

- (void)changeValue:(NSString *)value{
//    self.mMdate  =  [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    _mModeString = value;
//    [self.mMdate insertString:@"123" atIndex:0];
    [self.mMdate replaceObjectAtIndex:_mIndex.row withObject:value];
    DebugLog(@"接受到了%@",_mModeString);
    DebugLog(@"我现在的字符串的值为%@-----位置为%ld",self.mMdate,(long)_mIndex.row);
    [self.mTabView reloadRowsAtIndexPaths:@[_mIndex] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)successfullyadd:(id)sender{
    DebugLog("点击了提交按钮");
//    CLCollectionViewController *mDatajump = [CLCollectionViewController new];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [ mDatajump initWithModelData:_mModeString];
//    CLCollectionViewController *vc = [CLCollectionViewController new];
//    UIImageView *mImg = [UIImageView new];
//    mImg.image = [UIImage yh_imageNamed:@"pdf_collection_hint.pdf"];
////    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(200  , 200, 40, 40)];
////    label.backgroundColor = [UIColor redColor];
////    label.font = [UIFont systemFontOfSize:14];
////    label.text = @”提示信息
////    [self.view addSubview:label];
//    [self.view addSubview:mImg];
//    [mImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
//    //设置动画
//    CATransition * transion = [CATransition animation];
//    
//    transion.type = @"push";//设置动画方式
//    transion.subtype = @"fromRight";//设置动画从那个方向开始
////    [label.layer addAnimation:transion forKey:nil];//给Label.layer 添加动画 //设置延时效果
//    [mImg.layer addAnimation:transion forKey:nil];
//    //不占用主线程
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
////        [label removeFromSuperview];
//        [mImg removeFromSuperview];
//    });
//    [vc dismissViewControllerAnimated:YES completion:NULL];
    

}
@end
