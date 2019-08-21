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

@end

@implementation CLCollectionAdd

- (void)viewDidLoad {
    [super viewDidLoad]; self.title = @"添加新收款人";
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
    
    self.mImageView = [UIImageView new];
    [self loadData];
    _mModeString = @"请选择";
    _modelArray = @[@[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"],@[@"123",@"234",@"345",@"456",@"567"]];
}

- (void)loadData{
    _mAddLeftDateSource=@ [@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"联系号码"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mAddLeftDateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeLanguage *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLMeLanguage alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mMeLanguageLeftLabel.text = _mAddLeftDateSource[indexPath.row];
    if(indexPath.row == 0 ){
    cell.mIndexPath = indexPath;
    [cell updateView:CLMeLanguageType_textFiled and:nil];
    cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
        DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
        
    };}
    
    if(indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 3 || indexPath.row ==6){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_button and:_mModeString];
        cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
            NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
                    self.mSelectView = [CLCollectionAddSelect new];
                    self.mSelectView.delegate = self;//实现他的代理方法
                    self.mSelectView.modelArray  = modelArray;//把当前数据传入另一个j控制器的moderarrl里面;
                    [self.view addSubview:self.mSelectView.view];
        };
        
        
        
//        cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
//            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
//        };}
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
    _mModeString = value;
    DebugLog(@"%@",_mModeString);
    [self.mTabView reloadData];
}


@end
