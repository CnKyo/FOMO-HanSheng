//
//  CLCollectionAlter.m
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//
#import <WKWindowManagerFramework/WKWindowManagerFramework.h>
#import "CLCollectionAlter.h"

@interface CLCollectionAlter ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CLCollectionAddSelectDelegate>
@property (nonatomic,strong) NSString *mModeString;
@property (nonatomic,strong) UILabel *mLabel;
@property (nonatomic,strong) UIImageView *mImageView ;
@property (nonatomic,strong) NSArray *modelArray;
@property (nonatomic,strong) NSIndexPath *mIndex;
@property (nonatomic,strong) UIButton *mSendButton;
@property (nonatomic,strong) NSArray *mAddLeftDateSource;
@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;
@property (nonatomic,strong) NSMutableArray *mMdate;
@property (nonatomic,strong) NSString *mDl;
@end

@implementation CLCollectionAlter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改收款人信息";
    // Do any additional setup after loading the view.
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
    [self loadData];
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
}

- (void)loadData{
    _mAddLeftDateSource=@[@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"联系号码",@""];
    _modelArray = @[@[@"中国",@"马来西亚",@"菲律宾",@"越南",@"台湾",@"泰国",@"香港",@"新加坡",@"日本"],@[@"男",@"女"],@[@"DBS Bank Ltd",@"POSB国家储蓄银行",@"UOB大华银行",@"OCBC华侨银行"],@[@"本人",@"亲人",@"好友",@"同事"] ];
    _mModeString = @"请选择";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mAddLeftDateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 5){
        if(self.mDl.length >11){
            DebugLog(@"self.mdl的%@",self.mDl);
            return 60;
        }else{
            DebugLog(@"返回49的高度");
            return 49;
        }
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
    //////////////////////////////////////////////////////////////////////////////////以下为textfiled
    if(indexPath.row == 4 ){
        cell.mIndexPath = indexPath;
        [cell updateView:CLMeLanguageType_textFiled and:nil];
        cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
            //            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
            [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
            
        };}
    
    if(indexPath.row == 5){
        cell.mIndexPath = indexPath;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        UIView *mLineView = [UIView new];
        mLineView.backgroundColor = ssRGBHex(0xCCCCCC);
        [cell.contentView addSubview:mLineView];
        [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell);
            make.left.equalTo(cell).offset(15);
            make.height.offset(0.5);
            make.bottom.equalTo(cell);
        }];
        UILabel *mHint = [UILabel new];
        mHint.font = kCommonFont(12);
        mHint.textColor = ssRGBHex(0xD50037);
        mHint.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:mHint];
        [mHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mLineView.mas_bottom).offset(7);
            make.right.equalTo(cell).offset(-15);
            make.height.offset(12);
            
        }];
        [cell updateView:CLMeLanguageType_textFiled and:nil];
        cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
            self.mDl  = mText;
            if(mText.length >11){
                //                self.mDl = mText;
                self.mTabView.rowHeight = UITableViewAutomaticDimension;
                mLineView.backgroundColor = ssRGBHex(0xD50037);
                mHint.text = @"请输入正确的账户号码";
                NSIndexPath *mindexPath=[NSIndexPath indexPathForRow:8 inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:mindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                mLineView.backgroundColor = ssRGBHex(0xcccccc);
                //[WeakSelf.mHint removeFromSuperview];
                mHint.text = @"";
                NSIndexPath *mindexPath=[NSIndexPath indexPathForRow:8 inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:mindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];//刷新末尾的cell来实现重定义高度
                //                 self.mDl = mText;
                //                [self.mTabView reloadRowsAtIndexPaths:@[mIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
            }
            NSIndexPath *mindexPath=[NSIndexPath indexPathForRow:8 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:mindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            //             [self.mTabView reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationNone];
            //            CLMeLanguage *new = [CLMeLanguage new];
            //            [new initWithModelString:self.mDl];
        };}
    
    
    if(indexPath.row == 7){
        cell.mIndexPath = indexPath;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        UIView *mLineView = [UIView new];
        mLineView.backgroundColor = ssRGBHex(0xCCCCCC);
        [cell.contentView addSubview:mLineView];
        [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell);
            make.left.equalTo(cell).offset(15);
            make.height.offset(0.5);
            make.bottom.equalTo(cell);
        }];
        UILabel *mHint = [UILabel new];
        mHint.font = kCommonFont(12);
        mHint.textColor = ssRGBHex(0xD50037);
        mHint.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:mHint];
        [mHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mLineView.mas_bottom).offset(7);
            make.right.equalTo(cell).offset(-15);
            make.height.offset(12);
            
        }];
        [cell updateView:CLMeLanguageType_textFiled and:nil];
        cell.mBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
            //            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
            
            if(mText.length >11){
                mLineView.backgroundColor = ssRGBHex(0xD50037);
                mHint.text = @"请输入正确的联系号码";
            }else{
                mLineView.backgroundColor = ssRGBHex(0xcccccc);
                //                [WeakSelf.mHint removeFromSuperview];
                mHint.text = @"";
                [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
            }
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
    _mModeString = value;
    DebugLog(@"%@",_mModeString);
    //    [self.mTabView reloadData];
    
    [self.mTabView reloadRowsAtIndexPaths:@[_mIndex] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)successfullyadd:(id)sender{
    DebugLog("点击了提交按钮");
    //    CLCollectionViewController *mDatajump = [CLCollectionViewController new];
    CLCollectionAddSelect *vc = [CLCollectionAddSelect new];
    [WKTopWindow showWithViewController:vc];
  //  [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end