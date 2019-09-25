//
//  CLCollectionAdd.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//
#import "WKHudManager.h"
#import "CLCollectionAdd.h"
#import "CLCollectionAlterView.h"
@interface CLCollectionAdd ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
//CLCollectionAddSelectDelegate>//代理传值第4步
@property (nonatomic,strong) NSArray *mAddLeftDateSource;
@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;

@property (nonatomic,strong) NSString *mModeString;
@property (nonatomic,strong) NSString *mModeString2;
@property (nonatomic,strong) NSString *mModeString3;
@property (nonatomic,strong) NSString *mModeString4;
@property (nonatomic,strong) UILabel *mLabel;
@property (nonatomic,strong) UIImageView *mImageView ;
@property (nonatomic,strong) NSArray *modelArray;
@property (nonatomic,strong) NSIndexPath *mIndex;
@property (nonatomic,strong) UIButton *mSendButton;
@property (nonatomic,strong) NSMutableArray *mMdate;
@property (nonatomic,strong) NSString *mText;
@property (nonatomic,strong) NSString *mText2;
@property (strong,nonatomic)UILabel *mAcHintLable;

@property (strong,nonatomic)UILabel *mCoHitLabele;

@property (strong,nonatomic) NSMutableArray *mDataArr;

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
    self.mAcHintLable = [UILabel new];
    self.mCoHitLabele = [UILabel new];
    [self LoadCellType:12];
    self.mSendButton = [UIButton new];
    [self.mSendButton setTitle:@"提交" forState:UIControlStateNormal];
    self.mSendButton.enabled = NO;
    self.mSendButton.backgroundColor = ssRGBHex(0x8C9091);
//    self.mSendButton.backgroundColor = clBlueRGB;
    self.mSendButton.layer.cornerRadius = 4;
    [self.mSendButton addTarget:self action:@selector(successfullyadd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mSendButton];
    [self.mSendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(- BottomHeight - 10);
        make.height.offset(44);
        
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        }];
//    self.mImageView = [UIImageView new];
    [self loadData];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    UIView *mFooterView = [UIView new];
    mFooterView.backgroundColor = ssRGBHex(0xFFFFFF);
    //    mbgView.backgroundColor = ssRGBHex(0xF6F5FA);
    //    mbgView.backgroundColor= [UIColor redColor];
    mFooterView.frame = CGRectMake(0, 0,kScreenWidth , 34);
    UIView *mFootLine = [UIView new];
    mFootLine.backgroundColor = ssRGBHex(0xcccccc);
    [mFooterView addSubview:mFootLine];
    [mFootLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenWidth);
        make.height.offset(0.5);
        make.bottom.equalTo(mFooterView);
    }];
    self.mTabView.tableFooterView =mFooterView;
    
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
     NSArray *mArr = @[@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账户号码",@"关系",@"联系号码"];
//    _mAddLeftDateSource=@[@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"联系号码",@"c"];
//    _modelArray = @[@[@"中国",@"马来西亚",@"菲律宾",@"越南",@"台湾",@"泰国",@"香港",@"新加坡",@"日本"],@[@"男",@"女"],@[@"DBS Bank Ltd",@"POSB国家储蓄银行",@"UOB大华银行",@"OCBC华侨银行"],@[@"本人",@"亲人",@"好友",@"同事"] ];
    [self.mDataArr removeAllObjects];
    for(int i=0;i<mArr.count;i++){
        FormObj *mItem = [FormObj new];
        mItem.tag = i;
        mItem.mTitle = mArr[i];
//        mItem.mContent = _mTemp[i];
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
    if(mItem.needRefresh ){
        return 65;
        
    }
    return 50;
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
        cell.mResultBlock = ^(NSIndexPath *mIndexPath, FormObj *mItem) {
//            if((![mItem.mContent isEqualToString:@""]) && (mItem.mContent.length >0)){
//                self.mSendButton.enabled = YES;
//                self.mSendButton.backgroundColor = ssRGBHex(0x005CB6);
//            }
            if(mItem.needRefresh ==YES && mIndexPath.row == 5){
                
                weakSelf.mAcHintLable.text =@"请输入正确的账户号码";
                weakSelf.mAcHintLable.font = kCommonFont(12);
                weakSelf.mAcHintLable.textColor = ssRGBHex(0xD50037);
                [weakCell addSubview:weakSelf.mAcHintLable];
                [weakSelf.mAcHintLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakCell.mLineView.mas_bottom).mas_offset(7);
                    make.right.equalTo(weakCell).mas_offset(-15);
                }];
            }else if(mItem.needRefresh == NO && mIndexPath.row == 5){
                [weakSelf.mAcHintLable removeFromSuperview];
            }else if(mItem.needRefresh == YES && mIndexPath.row == 7){
                weakSelf.mCoHitLabele.text =@"请输入正确的联系号码";
                weakSelf.mCoHitLabele.font = kCommonFont(12);
                weakSelf.mCoHitLabele.textColor = ssRGBHex(0xD50037);
                [weakSelf.mTabView.tableFooterView addSubview:weakSelf.mCoHitLabele];
                [weakSelf.mCoHitLabele mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakCell.mLineView.mas_bottom).mas_offset(7);
                    make.right.equalTo(weakCell).mas_offset(-15);
                }];
            }else if(mItem.needRefresh == NO && mIndexPath.row == 7){
                
                [weakSelf.mCoHitLabele removeFromSuperview];
                
            };
            [weakSelf.mDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(idx == mIndexPath.row){
                    [weakSelf.mDataArr replaceObjectAtIndex:mIndexPath.row withObject:mItem];
                    [weakSelf.mTabView reloadData];
                }
//                if((mCellItem.mContent != nil) && (mCellItem.mContent.length >0)){
//                    self.mSendButton.enabled = YES;
//                    self.mSendButton.backgroundColor = ssRGBHex(0x005CB6);
//                }else{
//                    self.mSendButton.enabled = NO;
//                    self.mSendButton.backgroundColor = ssRGBHex(0x8C9091);
//                };
////
                
                
            }];
            for(int a=0;a<weakSelf.mDataArr.count;a++){
                FormObj *m = weakSelf.mDataArr[a];
                 if(m.mContent !=nil &&m.mContent.length >0){
                self.mSendButton.enabled = YES;
                self.mSendButton.backgroundColor = ssRGBHex(0x005CB6);
                }else{
                    self.mSendButton.enabled = NO;
                    self.mSendButton.backgroundColor = ssRGBHex(0x8C9091);
                    break;
                }
            }
          
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
//                if([mItem.mContent isEqualToString:@""]){
//                    weakSelf.mSendButton.enabled = YES;
//                    weakSelf.mSendButton.backgroundColor = ssRGBHex(0x005CB6);
//                };
            }];
            for(int a=0;a<weakSelf.mDataArr.count;a++){
                FormObj *m = weakSelf.mDataArr[a];
                if(m.mContent !=nil &&m.mContent.length >0){
                    self.mSendButton.enabled = YES;
                    self.mSendButton.backgroundColor = ssRGBHex(0x005CB6);
                }else{
                    self.mSendButton.enabled = NO;
                    self.mSendButton.backgroundColor = ssRGBHex(0x8C9091);
                    break;
                }
            }
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


-(void)successfullyadd:(id)sender{
    DebugLog(@"%@",self.mMdate);
    [self AddAccount:self.mDataArr];
    

    
}
- (void)AddAccount:(NSArray *)Array{
    for (NSString *text in Array) {
        if ([CLTool deleteSpace:text].length<=0) {
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
//            [para setObject:[CLTool deleteSpace:m.mContent] forKey:@"accountNumber"];
//            [para setObject:m.mContent forKey:@"accountNumber"]
            
        }else if([m.mTitle isEqualToString:@"关系"]){
            [para setObject:m.mContent  forKey:@"relationship"];
        }else if([m.mTitle isEqualToString:@"联系号码"]){
            [para setObject:m.mContent  forKey:@"contactNumber"];
        }
        
    }
    
    [self showLoading:@"Creating..."];
    [WKNetWorkManager WKCreateRecipientAcc:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            [SVStatusHUD showWithImage:[UIImage yh_imageNamed:@"pdf_info_success"] status:languageStr(@"Create")];
//            TOASTMESSAGE(@"Recipient Create Successful!");
            if (self.mBackBlock) {
                self.mBackBlock(YES);
            }
            [self popToViewController];
        }else{
            TOASTMESSAGE(result);
        }
    }];
}
@end
