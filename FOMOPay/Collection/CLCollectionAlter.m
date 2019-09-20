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

//@property (nonatomic,strong) UILabel *mLabel;
//@property (nonatomic,strong) UIImageView *mImageView ;
@property (nonatomic,strong) NSArray *modelArray;
@property (nonatomic,strong) NSIndexPath *mIndex;
@property (nonatomic,strong) UIButton *mSendButton;
@property (nonatomic,strong) NSArray *mAddLeftDateSource;
@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;
@property (nonatomic,strong) NSMutableArray *mMdate;
@property (nonatomic,strong) NSArray *mTemp;
@property (nonatomic,strong) NSString *mText;
@property (nonatomic,strong) NSString *mText2;

@property (nonatomic,strong) NSIndexPath *mCurrentIndex;


@property (nonatomic,strong) NSDictionary *mDic;

@property (strong,nonatomic) NSMutableArray *mDataArr;
@property (strong,nonatomic) NSArray *mTempArr;

@property (strong,nonatomic)UILabel *mAcHintLable;

@property (strong,nonatomic)UILabel *mCoHitLabele;

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
    self.mAcHintLable = [UILabel new];
    self.mCoHitLabele = [UILabel new];
    [self LoadCellType:12];
    self.mSendButton = [UIButton new];
    [self.mSendButton setTitle:@"提交" forState:UIControlStateNormal];
    self.mSendButton.backgroundColor = clBlueRGB;
    self.mSendButton.layer.cornerRadius = 4;
    [self.mSendButton addTarget:self action:@selector(successfullyadd:) forControlEvents:UIControlEventTouchUpInside];
    self.mSendButton.enabled = NO;
    self.mSendButton.backgroundColor = ssRGBHex(0x8C9091);
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

- (NSMutableArray *)mDataArr{
    if(!_mDataArr){
        _mDataArr = [NSMutableArray new];
    }
    return _mDataArr;
}



- (void)loadData{
    NSArray *mArr = @[@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账户号码",@"关系",@"联系号码",@""];
    _mTemp = @[_mData.fullName,_mData.nationality,[self mGender:_mData.gender],_mData.bankName,_mData.bankCity,[self formmatterBankCardNum:_mData.accountNumber],_mData.relationship,_mData.contactNumber,@""];
    
    [self.mDataArr removeAllObjects];
    for(int i=0;i<mArr.count;i++){
        FormObj *mItem = [FormObj new];
        mItem.tag = i;
        mItem.mTitle = mArr[i];
        mItem.mContent = _mTemp[i];
        if(i==0 || i==4 ||i==5 ||i==7){
            mItem.type = 2;
        }else{
            mItem.type = 1;
        }
        [self.mDataArr addObject:mItem];
        
       
        
    }
    
    
    [self.mTabView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mDataArr.count;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FormObj *mItem = self.mDataArr[indexPath.row];
    if(mItem.needRefresh &&mItem.tag ==6 ){
        return 61;
        
    }
    return 49;
//    if (self.mCurrentIndex.row == indexPath.row) {
//        return 49;
//    }else{
//        if(indexPath.row == 6){
//            if([self.mText isEqualToString:@""]){
//                return 61;
//            }else{
//                return 49;
//            }
//        }else if(indexPath.row == 8){
//            if([self.mText2 isEqualToString:@""]){
//                return 55;
//            }else{
//                return 34;
//            }
//        }else{
//            return 49;
//
//        }
//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    
    NSString *String = @"cell";
    NSString *StringButton = @"cellButton";
    FormObj *mCellItem = self.mDataArr[indexPath.row];
    if(mCellItem.type == 2){
        CLCollectionAlterView *cell = [tableView dequeueReusableCellWithIdentifier:String forIndexPath:indexPath];
        if (!cell){
            cell = [[CLCollectionAlterView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:String];
            }
        __weak __typeof(cell)weakCell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.mIndexPath = indexPath;
        cell.mLineBlock = ^(NSIndexPath *mIndexPath, NSInteger i) {
             FormObj *mCItem = self.mDataArr[mIndexPath.row +1];
            if(i == 0){
                mCItem.needRefresh = YES;
                
            }else{
                mCItem.needRefresh =NO;
            }
            
             [self.mTabView reloadData];
        };
//        cell.mLineBlock = ^(NSIndexPath *mIndexPath,NSInteger ) {
//            FormObj *mCItem = self.mDataArr[mIndexPath.row +1];
//            mCItem.needRefresh = YES;
//            [self.mTabView reloadData];
//        };
        cell.mResultBlock = ^(NSIndexPath *mIndexPath, FormObj *mItem) {
            if((![mItem.mContent isEqualToString:self.mTemp[mIndexPath.row]]) && (mItem.mContent.length >0)){
                self.mSendButton.enabled = YES;
                self.mSendButton.backgroundColor = ssRGBHex(0x005CB6);
            }
            [weakSelf.mDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(idx == mIndexPath.row){
                    [weakSelf.mDataArr replaceObjectAtIndex:mIndexPath.row withObject:mItem];
                    [weakSelf.mTabView reloadData];
                }
              
                if(mItem.needRefresh ==YES){
                   
                    weakSelf.mAcHintLable.text =@"aaa";
                    [weakCell addSubview:weakSelf.mAcHintLable];
                    [weakSelf.mAcHintLable mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(weakCell.mLineView.mas_bottom).mas_offset(7);
                        make.right.equalTo(weakCell).mas_offset(-15);
                    }];
                }else{
//
                    
                };
                
            }];
        };
       
        [cell updateItemText:mCellItem];
         return cell;
        
        
        
        
    }else{
        CLCollectionAlterView *cell = [tableView dequeueReusableCellWithIdentifier:StringButton forIndexPath:indexPath];
        if (!cell){
            cell = [[CLCollectionAlterView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StringButton];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.mIndexPath = indexPath;
        [cell updateItemButton:mCellItem];
        cell.mBackBlcok = ^(NSIndexPath *mIndexPath, FormObj *mItem) {
            [weakSelf.mDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(idx == mIndexPath.row){
                    [weakSelf.mDataArr replaceObjectAtIndex:mIndexPath.row withObject:mItem];
                    [weakSelf.mTabView reloadData];
                }
                if(mItem.mContent != weakSelf.mTemp[mIndexPath.row]){
                    weakSelf.mSendButton.enabled = YES;
                    weakSelf.mSendButton.backgroundColor = ssRGBHex(0x005CB6);
                };
            }];
        };
//        cell.mResultBlock = ^(NSIndexPath *mIndexPath, FormObj *mItem) {
//            [weakSelf.mDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if(idx == mIndexPath.row){
//                    [weakSelf.mDataArr replaceObjectAtIndex:mIndexPath.row withObject:mItem];
//                    [weakSelf.mTabView reloadData];
//                }
//            }];
//        };
        return cell;
        }
    
    
    

}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *mView = [UIView new];
//    mView.backgroundColor = ssRGBHex(0xffffff);
//    UIView *mLineView = [UIView new];
//    mLineView.backgroundColor = ssRGBHex(0xe6e6e6);
//    [mView addSubview:mLineView];
//    [mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(mView).mas_offset(0);
//        make.height.offset(1);
//        make.width.offset(kScreenWidth);
//    }];
//    return mView;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 34;
////    return 55;
//}


-(void)successfullyadd:(id)sender{
    DebugLog(@"%@",self.mMdate);
    [self AlterAccount:self.mDataArr];
}


-(void)AlterAccount:(NSArray *)Array{
    for(NSString *text in Array){
        if([CLTool deleteSpace:text].length <=0){
            TOASTMESSAGE(@"您必须完善您的资料信息!");
            return;
        }
    }
    NSMutableDictionary *para = [NSMutableDictionary new];
    for(int i=0;i<_mDataArr.count;i++){
        FormObj *m = _mDataArr[i];
        if([m.mTitle isEqualToString:@"全名"]){
            [para setObject:m.mContent forKey:@"fullName"];
        }else if([m.mTitle isEqualToString:@"国籍"]){
            [para setObject:m.mContent  forKey:@"nationality"];
             [para setObject:[CLTool getCuurenceCode:m.mContent] forKey:@"currencyCode"];
        }else if([m.mTitle isEqualToString:@"性别"]){
            if([m.mContent isEqualToString:@"男"]){
                [para setObject:@"MALE" forKey:@"gender"];
            }else if([m.mContent isEqualToString:@"女"]){
                [para setObject:@"FEMALE" forKey:@"gender"];
            }
        }else if([m.mTitle isEqualToString:@"银行"]){
            [para setObject:m.mContent  forKey:@"bankName"];
        }else if([m.mTitle isEqualToString:@"开户地址/城市"]){
            [para setObject:m.mContent  forKey:@"bankCity"];
        }else if([m.mTitle isEqualToString:@"账户号码"]){
            [para setObject:[CLTool deleteSpace:m.mContent] forKey:@"accountNumber"];
//            [para setObject:m.mContent  forKey:@"accountNumber"];
        }else if([m.mTitle isEqualToString:@"关系"]){
            [para setObject:m.mContent  forKey:@"relationship"];
        }else if([m.mTitle isEqualToString:@"联系号码"]){
             [para setObject:m.mContent  forKey:@"contactNumber"];
        }
//        [para setObject:[CLTool getCuurenceCode:Array[1]] forKey:@"currencyCode"];
    }
    
//    NSMutableDictionary *para = [NSMutableDictionary new];
   
//    [para setObject:Array[0] forKey:@"fullName"];
//    [para setObject:Array[1] forKey:@"nationality"];
//
//
//    if ([Array[2] isEqualToString:@"男"]) {
//        [para setObject:@"MALE" forKey:@"gender"];
//
//    }else if ([Array[2] isEqualToString:@"女"]){
//        [para setObject:@"FEMALE" forKey:@"gender"];
//    }
//
//    [para setObject:Array[3] forKey:@"bankName"];
//    [para setObject:Array[4] forKey:@"bankCity"];
//    [para setObject:[CLTool deleteSpace:Array[5]] forKey:@"accountNumber"];
//    [para setObject:Array[6] forKey:@"relationship"];
//    [para setObject:Array[7] forKey:@"contactNumber"];
//    [para setObject:[CLTool getCuurenceCode:Array[1]] forKey:@"currencyCode"];
    
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

- (NSString *)mGender:(NSString *)gender{
    if([gender isEqualToString:@"MALE"]){
        return @"男";
        
    }else{
        return @"女";
    }
}

#pragma mark----****----转化卡号为每4位加一个空格
-(NSString *)formmatterBankCardNum:(NSString *)string{
    NSString *tempStr = string;
    
    NSInteger size = (tempStr.length/4);
    
    NSMutableArray *tempStrArr = [[NSMutableArray alloc]init];
    
    for(int i=0;i<size;i++){
        [tempStrArr addObject:[tempStr substringWithRange:NSMakeRange(i*4, 4)]];
    }
    
    [tempStrArr addObject:[tempStr substringWithRange:NSMakeRange(size*4,(tempStr.length%4))]];
    
    tempStr = [tempStrArr componentsJoinedByString:@" "];
    
    return tempStr;
}

@end
