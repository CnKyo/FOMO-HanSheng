//
//  CLCollectionAlter.m
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//
#import <WKWindowManagerFramework/WKWindowManagerFramework.h>
#import "CLCollectionAlter.h"
#import "CLCollectionAlterView.h"
#import "HomeRefundSelectBankView.h"
@interface CLCollectionAlter ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CLCollectionAddSelectDelegate>
@property (nonatomic,strong) NSString *mModeString;
@property (nonatomic,strong) NSString *mModeString2;
@property (nonatomic,strong) NSString *mModeString3;
@property (nonatomic,strong) NSString *mModeString4;
@property (nonatomic,strong) NSString *mTextName;
@property (nonatomic,strong) NSString *mTextcity;
@property (nonatomic,strong) NSString *mTextAccNumber;
@property (nonatomic,strong) NSString *mTextConNumber;
//@property (nonatomic,strong) UILabel *mLabel;
//@property (nonatomic,strong) UIImageView *mImageView ;
@property (nonatomic,strong) NSArray *modelArray;
@property (nonatomic,strong) NSIndexPath *mIndex;
@property (nonatomic,strong) UIButton *mSendButton;
@property (nonatomic,strong) NSArray *mAddLeftDateSource;
@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;
@property (nonatomic,strong) NSMutableArray *mMdate;
@property (nonatomic,strong) NSString *mText;
@property (nonatomic,strong) NSString *mText2;
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
    
    [self LoadCellType:12];
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
    //    self.mImageView = [UIImageView new];
    [self loadData];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];//关闭键盘手势
    
}



-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
}

- (void)loadData{
    _mAddLeftDateSource=@[@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"联系号码",@""];
    _modelArray = @[@[@"中国",@"马来西亚",@"菲律宾",@"越南",@"台湾",@"泰国",@"香港",@"新加坡",@"日本"],@[@"男",@"女"],@[@"DBS Bank Ltd",@"POSB国家储蓄银行",@"UOB大华银行",@"OCBC华侨银行"],@[@"本人",@"亲人",@"好友",@"同事"] ];
//    _mModeString = @"请选择";
    _mTextName = self.mData.fullName;
    _mTextConNumber = self.mData.contactNumber;
    _mTextAccNumber = self.mData.accountNumber;
    _mTextcity = self.mData.bankCity;
    _mModeString = self.mData.nationality;
    _mModeString2 = self.mData.gender;
    _mModeString3 = self.mData.bankName;
    _mModeString4 = self.mData.relationship;
    
    self.mMdate  =[@[_mTextName, _mModeString, _mModeString2,_mModeString3,_mTextcity,_mTextAccNumber,_mModeString4,_mTextConNumber] mutableCopy];
    //    [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mAddLeftDateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 6){
        if([self.mText isEqualToString:@""]){
            return 61;
        }else{
            return 49;
        }
    }else if(indexPath.row == 8){
        if([self.mText2 isEqualToString:@""]){
            return 55;
        }else{
            return 34;
        }
    }else{
        return 49;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        CLCollectionAlterView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[CLCollectionAlterView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
    
//        self.mTabView.separatorStyle= UITableViewCellSeparatorStyleNone;
        __weak typeof(cell)  weakCell = cell;
                WS(weakSelf);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    self.mTabView.separatorStyle= UITableViewCellSeparatorStyleNone;
        //    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        cell.mLeftName.text = _mAddLeftDateSource[indexPath.row];
        cell.mLeftName.font = kCommonFont(14);
        cell.mIndexPath = indexPath;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
   
    if(indexPath.row == 0 ){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);

            }];
            [cell updateView:CLCollectionAlter_textFiled and:_mTextName];
            cell.mAlterBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
                weakSelf.mTextName = mText;
                [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];

            };}

        if(indexPath.row == 1){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);

            }];
           
            [cell updateView:CLCollectionAlter_button and:_mModeString];
//            cell.mLb.text = self.mData.nationality;
            cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
//                NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
                self.mSelectView = [CLCollectionAddSelect new];
//                self.mSelectView.delegate = self;//实现他的代理方法//代理传值第五步
                self.mSelectView.modelArray  = [self.modelArray objectAtIndex:0];//把当前数据传入另一个j控制器的moderarrl里面;
                [self.view addSubview:self.mSelectView.view];
                [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
                weakSelf.mSelectView.CLCollectionAddSelectBlock = ^(NSString * _Nonnull string, NSInteger tag) {
                    weakCell.mLb.text = string;
                    weakCell.mLb.textColor = ssRGBHex(0x2b2b2b);
                    [weakSelf.mMdate replaceObjectAtIndex:indexPath.row withObject:string];
                    DebugLog(@"%@",weakSelf.mMdate[indexPath.row]);
                    weakSelf.mModeString = string;
                };
                self.mIndex = indexPath;

            };}
        if(indexPath.row == 2){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);

            }];
            [cell updateView:CLCollectionAlter_button and:_mModeString2];
            cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {

                self.mSelectView = [CLCollectionAddSelect new];
//                self.mSelectView.delegate = self;//实现他的代理方法
                self.mSelectView.modelArray  = [self.modelArray objectAtIndex:1];//把当前数据传入另一个j控制器的moderarrl里面;
                [self.view addSubview:self.mSelectView.view];
                [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
                weakSelf.mSelectView.CLCollectionAddSelectBlock = ^(NSString * _Nonnull string, NSInteger tag) {
                    weakCell.mLb.text = string;
                    weakCell.mLb.textColor = ssRGBHex(0x2b2b2b);
                     [weakSelf.mMdate replaceObjectAtIndex:indexPath.row withObject:string];
                    weakSelf.mModeString2 = string;
                };
                self.mIndex = indexPath;
            };}
        if(indexPath.row == 3){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);

            }];
            [cell updateView:CLCollectionAlter_button and:_mModeString3];
            cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {

                self.mSelectView = [CLCollectionAddSelect new];
//                self.mSelectView.delegate = self;//实现他的代理方法
                self.mSelectView.modelArray  = [self.modelArray objectAtIndex:2];//把当前数据传入另一个j控制器的moderarrl里面;
                [self.view addSubview:self.mSelectView.view];
                [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
                weakSelf.mSelectView.CLCollectionAddSelectBlock = ^(NSString * _Nonnull string, NSInteger tag) {
                    weakCell.mLb.text = string;
                    weakCell.mLb.textColor = ssRGBHex(0x2b2b2b);
                    [weakSelf.mMdate replaceObjectAtIndex:indexPath.row withObject:string];
                    weakSelf.mModeString3 = string;
                };
                self.mIndex = indexPath;
            };}

        if(indexPath.row == 6){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);

            }];
            [cell updateView:CLCollectionAlter_button and:_mModeString4];
            cell.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
                self.mSelectView = [CLCollectionAddSelect new];
//                self.mSelectView.delegate = self;//实现他的代理方法
                self.mSelectView.modelArray  = [self.modelArray objectAtIndex:3];//把当前数据传入另一个j控制器的moderarrl里面;
                [self.view addSubview:self.mSelectView.view];
                [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
                weakSelf.mSelectView.CLCollectionAddSelectBlock = ^(NSString * _Nonnull string, NSInteger tag) {
                    weakCell.mLb.text = string;
                    weakCell.mLb.textColor = ssRGBHex(0x2b2b2b);
                    [weakSelf.mMdate replaceObjectAtIndex:indexPath.row withObject:string];
                    weakSelf.mModeString4 = string;
                };
                self.mIndex = indexPath;
            };}



        //////////////////////////////////////////////////////////////////////////////////以下为textfiled
        if(indexPath.row == 4 ){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);

            }];
            [cell updateView:CLCollectionAlter_textFiled and:_mTextcity];
            cell.mAlterBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
                //            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
                weakSelf.mTextcity = mText;
                [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];

            };}

        if(indexPath.row == 5){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);

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
            [cell updateView:CLCollectionAlter_textFiled and:_mTextAccNumber];
            cell.mAlterBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
                self.mText  = mText;
                if(mText.length <=0 ){
                    mLineView.backgroundColor = ssRGBHex(0xD50037);
                    mHint.hidden = NO;
                    mHint.text = @"请输入正确的账户号码";
                }else{
                    mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
                    mHint.text = @"";
                    mHint.hidden = YES;
                     weakSelf.mTextAccNumber = mText;
                    [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
                }
                NSIndexPath *mindexPath=[NSIndexPath indexPathForRow:8 inSection:0];
               
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:mindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                //
            };}


        if(indexPath.row == 7){
            cell.mIndexPath = indexPath;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            UIView *mLineView = [UIView new];
            mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
            [cell.contentView addSubview:mLineView];
            [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell);
                make.left.equalTo(cell).offset(15);
                make.height.offset(1);
                make.top.equalTo(cell.mLeftName.mas_bottom).mas_offset(11);
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
            [cell updateView:CLCollectionAlter_textFiled and:_mTextConNumber];
            cell.mAlterBlock = ^(NSIndexPath * _Nonnull mIndexPath, NSString * _Nonnull mText) {
                //            DebugLog(@"当前的索引:%ld,内容是:%@",(long)mIndexPath.row,mText);
                self.mText2 = mText;
                if(mText.length <= 0){
                    mLineView.backgroundColor = ssRGBHex(0xD50037);
                    mHint.text = @"请输入正确的联系号码";
                }else{
                    mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
                    //                [WeakSelf.mHint removeFromSuperview];
                    mHint.text = @"";
                    weakSelf.mTextConNumber = mText;
                    [self.mMdate replaceObjectAtIndex:indexPath.row withObject:mText];
                }
                NSIndexPath *mindexPath=[NSIndexPath indexPathForRow:8 inSection:0];
                
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:mindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                //
            };}
    
        if(indexPath.row == 8){
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            cell.mLeftName.text = @"";
            [cell updateView:CLCollectionAlter_other and:nil];
            UIView *mLineView = [UIView new];
            mLineView.hidden = YES;
        }
 
    return cell;
}




//- (void)changeValue:(NSMutableString *)value{ // 第6步接受
//    //    self.mMdate  =  [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
//    _mModeString = value;
//
//    //    [self.mMdate insertString:@"123" atIndex:0];
//    [self.mMdate replaceObjectAtIndex:_mIndex.row withObject:value];
//    DebugLog(@"接受到了%@",_mModeString);
//    DebugLog(@"我现在的字符串的值为%@-----位置为%ld",self.mMdate,(long)_mIndex.row);
//    [self.mTabView reloadRowsAtIndexPaths:@[_mIndex] withRowAnimation:UITableViewRowAnimationNone];
//}

-(void)successfullyadd:(id)sender{
    DebugLog(@"%@",self.mMdate);
    [self AlterAccount:self.mMdate];
}


-(void)AlterAccount:(NSArray *)Array{
    for(NSString *text in Array){
        if([CLTool deleteSpace:text].length <=0){
            TOASTMESSAGE(@"您必须完善您的资料信息!");
            return;
        }
    }
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:Array[0] forKey:@"fullName"];
    [para setObject:Array[1] forKey:@"nationality"];
    
    if ([Array[2] isEqualToString:@"男"]) {
        [para setObject:@"MALE" forKey:@"gender"];
        
    }else if ([Array[2] isEqualToString:@"女"]){
        [para setObject:@"FEMALE" forKey:@"gender"];
    }
    
    [para setObject:Array[3] forKey:@"bankName"];
    [para setObject:Array[4] forKey:@"bankCity"];
    [para setObject:[CLTool deleteSpace:Array[5]] forKey:@"accountNumber"];
    [para setObject:Array[6] forKey:@"relationship"];
    [para setObject:Array[7] forKey:@"contactNumber"];
    [para setObject:[CLTool getCuurenceCode:Array[1]] forKey:@"currencyCode"];
    
    [self showLoading:@"Altering..."];
    
    [WKNetWorkManager WKModifyRecipientInfo:_mData.id andPara:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if(success){
            TOASTMESSAGE(@"修改成功");
            if(self.mBackBlock){
                self.mBackBlock(YES);
            }
            [self popToViewController];
        }else{
//            TOASTMESSAGE(result);
            TOASTMESSAGE(languageStr(@"AlterErr"));
        }
    }];
}
@end
