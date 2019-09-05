//
//  HomeSureInfoViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeSureInfoViewController.h"

#import "HomeSureInfoEditCell.h"
#import "HomeSureInfoListCell.h"
#import "HomeRefundSelectBankView.h"
#import "HomeChangeAmountVC.h"
#import "HomeSelectPayeeViewController.h"
#import "CLMeClauseOfTreaty.h"
#import "HomeSureInfoLIstCellone.h"
@interface HomeSureInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) HomeRefundSelectBankView *purposeView;
@property (nonatomic, strong) HomeRefundSelectBankView *sourceView;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) NSString *mPurpose;

@property (nonatomic, strong) NSString *mSourceFund;

@end

@implementation HomeSureInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"确认讯息";
    
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    
    NSArray *array1 = @[@"收款人",@"账户号码",@"关系",];
    NSArray *array2 = @[@"汇款金额",@"获得金额",@"汇率",@"手续费",];
    NSArray *array3 = @[@"汇款目的",@"资金来源",@"总金额",];
    
    _dataSourceArray = @[array1,array2,array3];
    
    [self initialView];
}

- (void)initialView{
    
    [self loadBottomView];

    [self loadTableView];
}

- (void)loadTableView{
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeSureInfoListCell" bundle:nil] forCellReuseIdentifier:@"HomeSureInfoListCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeSureInfoEditCell" bundle:nil] forCellReuseIdentifier:@"HomeSureInfoEditCell"];
   [_myTableView registerNib:[UINib nibWithNibName:@"HomeSureInfoLIstCellone" bundle:nil] forCellReuseIdentifier:@"HomeSureInfoLIstCellone"];
    [self loadData];
}
- (void)loadData{
    [self showLoading:nil];
    
    [WKNetWorkManager WKGetRecipientDetail:self.mItem.id block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            self.mItem = [WKResipientInfoObj yy_modelWithDictionary:[[CLTool stringToDic:result] objectForKey:@"recipient"]];
        }else{
            TOASTMESSAGE(result);
        }
    }];
}
- (void)loadBottomView{
    WS(weakSelf);
    NSInteger bottomSafeHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        
        UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
        bottomSafeHeight = safeArea.bottom;
        
    }else{
        
        bottomSafeHeight = 0;
    }
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomView];
    
    UIButton *selectButton = [[UIButton alloc] init];
    [selectButton setImage:[UIImage yh_imageNamed:@"pdf_home_sureInfo_PrivacyPolicy_gray"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage yh_imageNamed:@"pdf_home_sureInfo_PrivacyPolicy"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:selectButton];
    
    WPHotspotLabel *mTerms = [[WPHotspotLabel alloc] init];
    mTerms.textColor = kCommonColor(140, 144, 145, 1);
    mTerms.textAlignment = NSTextAlignmentLeft;
    mTerms.numberOfLines = 2;
    mTerms.font = [UIFont systemFontOfSize:12];
    NSDictionary* mStyle = @{
                             @"termsAction":[WPAttributedStyleAction styledActionWithAction:^{
                                 [weakSelf goTerms];
                             }],@"color":kCommonColor(0, 92, 182, 1)};
    mTerms.attributedText=[@"我同意汉生条款和条件，包括：\n<termsAction><color>隐私政策，使用条款和可接受的使用政策</color></termsAction>" attributedStringWithStyleBook:mStyle];
    [_bottomView addSubview:mTerms];
    
    
    self.sureButton = [[UIButton alloc] init];
    [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureButton.backgroundColor = kCommonGrayColor;
    self.sureButton.layer.cornerRadius = 4.0;
    self.sureButton.enabled = NO;
    [self.sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:self.sureButton];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10-bottomSafeHeight);
        make.height.equalTo(@122);
    }];
    
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.bottomView).offset(20);
        make.left.equalTo(self.bottomView).offset(15);
        make.width.height.equalTo(@20);
    }];
    
    [mTerms mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(selectButton.mas_right).offset(10);
        make.right.equalTo(self.bottomView.mas_right).offset(-10);

        make.top.equalTo(selectButton.mas_top).offset(-5);
        make.height.equalTo(@35);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(mTerms.mas_bottom).offset(20);
        make.left.equalTo(self.bottomView).offset(10);
        make.right.equalTo(self.bottomView).offset(-10);
        make.height.equalTo(@44);
    }];
    


}

- (void)goTerms{
    CLMeClauseOfTreaty *vc = [CLMeClauseOfTreaty new];
    [self pushToViewController:vc];
}

- (void)selectButtonClicked:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    self.sureButton.enabled = sender.selected;
    if (sender.selected) {
        self.sureButton.backgroundColor = kLoginTitleColor;
    }else{
        self.sureButton.backgroundColor = kCommonGrayColor;
    }
}

- (void)sureButtonClicked:(UIButton *)sender{
    DebugLog(@"确认");
    [self showLoading:nil];
    if (self.mPurpose.length<=0) {
        self.mPurpose = @"生活费";
    }
    if (self.mSourceFund.length<=0) {
        self.mSourceFund = @"投资收入";
    }
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    [para setObject:[CLTool WKDicToJsonString:[self.mCurrentRemmitance yy_modelToJSONObject]] forKey:@"remittable"];
    [para setObject:self.mItem.id forKey:@"recipientId"];
    [para setObject:@"PAYNOW" forKey:@"paymentType"];
    ///目的
    [para setObject:self.mPurpose forKey:@"purpose"];
    ///涞源
    [para setObject:self.mSourceFund forKey:@"sourceOfFund"];

    [WKNetWorkManager WKRemiitanceNow:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            TOASTMESSAGE(@"您的汇款申请已成功提交!");
            [self popToViewController:2];
        }else{
            TOASTMESSAGE(result);
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = _dataSourceArray[section];
    if (section == _dataSourceArray.count - 1) {
        
        return array.count;
        
    }else{
        
        return array.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = _dataSourceArray[indexPath.section];

    if (indexPath.section == _dataSourceArray.count - 1) {
        
        HomeSureInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSureInfoListCell"];
        if (!cell) {
            
            cell = [[HomeSureInfoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSureInfoListCell"];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == array.count - 1) {
            
            cell.showImage.hidden = YES;
            cell.contentLabel.textColor = kCommonColor(43, 43, 43, 1);
            
        }else{
            
            cell.showImage.hidden = NO;
            cell.contentLabel.textColor = kLoginTitleColor;
        }
        
        cell.titleLabel.text = array[indexPath.row];
        NSString *mContent = array[indexPath.row];
        if ([mContent isEqualToString:@"汇款目的"]) {
            cell.contentLabel.text = @"生活费";
        }else if ([mContent isEqualToString:@"资金来源"]){
            cell.contentLabel.text = @"投资收入";
        }else if ([mContent isEqualToString:@"总金额"]){
            cell.contentLabel.text = [NSString stringWithFormat:@"%@%@",self.mCurrentRemmitance.chargable.currencyCode,self.mCurrentRemmitance.chargable.amount];
            [cell.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).mas_offset(-15);
            }];
        }
        return cell;
        
    }else{
        
        if (indexPath.row == array.count) {
            
            HomeSureInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSureInfoEditCell"];
            if (!cell) {
                
                cell = [[HomeSureInfoEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSureInfoEditCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            
            HomeSureInfoLIstCellone *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSureInfoLIstCellone"];
            if (!cell) {
                
                cell = [[HomeSureInfoLIstCellone alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSureInfoLIstCellone"];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.showImage.hidden = YES;
            cell.contentLabel.textColor = kCommonColor(43, 43, 43, 1);
            NSString *mContent = array[indexPath.row];
            cell.titleLabel.text = mContent;
            if ([mContent isEqualToString:@"收款人"]) {
                cell.contentLabel.text = self.mItem.fullName;
            }else if ([mContent isEqualToString:@"账户号码"]){
                cell.contentLabel.text = self.mItem.accountNumber;
            }else if ([mContent isEqualToString:@"关系"]){
                cell.contentLabel.text = self.mItem.relationship;
            }else if ([mContent isEqualToString:@"汇款金额"]){
                cell.contentLabel.text = self.mCurrentRemmitance.source.amount;
            }else if ([mContent isEqualToString:@"获得金额"]){
                cell.contentLabel.text = self.mCurrentRemmitance.target.amount;
            }else if ([mContent isEqualToString:@"汇率"]){
                cell.contentLabel.text = self.mCurrentRemmitance.rate;
            }else if ([mContent isEqualToString:@"手续费"]){
                cell.contentLabel.text = self.mCurrentRemmitance.serviceCharge.amount;
            }
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeSureInfoListCell *cell = (HomeSureInfoListCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    __weak __typeof(self)weakSelf = self;
    CGRect mFrame = [UIApplication sharedApplication].keyWindow.bounds;

    if (indexPath.section == _dataSourceArray.count - 1) {
        
        if (indexPath.row == 0) {
            
            NSArray *array = @[@"购买产品",@"生活费",@"学费",@"房租",@"餐费"];
            _purposeView = [HomeRefundSelectBankView shareView];
            _purposeView.frame = mFrame;
            _purposeView.titleLabel.text = @"汇款目的";
            [_purposeView updataSource:array];
            _purposeView.HomeRefundSelectBankViewBlock = ^(NSString *string, NSInteger tag) {
                
                [weakSelf.purposeView removeFromSuperview];
                weakSelf.purposeView = nil;
                
                if (tag == 1001) {
                    
                    cell.contentLabel.text = string;
                    weakSelf.mPurpose = string;
                }
            };
            
            [[UIApplication sharedApplication].keyWindow addSubview:_purposeView];
            
        }else if (indexPath.row == 1){
            
            NSArray *array = @[@"工资",@"投资收入",@"经营所得",@"劳务报酬",@"股息红利及利息所得",@"住房补贴",@"其他所得"];
            _sourceView = [HomeRefundSelectBankView shareView];
            _sourceView.frame = mFrame;
            _sourceView.titleLabel.text = @"资金来源";
            [_sourceView updataSource:array];
            _sourceView.HomeRefundSelectBankViewBlock = ^(NSString *string, NSInteger tag) {
                
                [weakSelf.sourceView removeFromSuperview];
                weakSelf.sourceView = nil;
                
                if (tag == 1001) {
                    
                    cell.contentLabel.text = string;
                    weakSelf.mSourceFund = string;
                }
            };
            
            [[UIApplication sharedApplication].keyWindow addSubview:_sourceView];
        }
    }else{
        
        NSArray *array = _dataSourceArray[indexPath.section];
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == array.count) {
                
                HomeSelectPayeeViewController *vc = [[HomeSelectPayeeViewController alloc] init];
                vc.type = ShowButtonTypeChange;
                [weakSelf pushToViewController:vc];
            }
            
        }else if (indexPath.section == 1){
            
            if (indexPath.row == array.count) {
                
                HomeChangeAmountVC *vc = [[HomeChangeAmountVC alloc] init];
                [self pushToViewController:vc];
            }
        }
    }
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    if ([[URL scheme] isEqualToString:@"healthservice"]) {
        
        //《健康档案服务协议》点击事件
        NSLog(@"点击隐私政策");
        return NO;
    }
    
    return YES;
}


@end
