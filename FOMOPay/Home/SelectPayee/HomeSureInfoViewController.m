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

@interface HomeSureInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) HomeRefundSelectBankView *purposeView;
@property (nonatomic, strong) HomeRefundSelectBankView *sourceView;

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
}

- (void)loadBottomView{
    
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
    
    UITextView *contentTextView = [[UITextView alloc] init];
    contentTextView.attributedText = [self getContentLabelAttributedText];
    contentTextView.textAlignment = NSTextAlignmentLeft;
    contentTextView.delegate = self;
    contentTextView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    contentTextView.font = kCommonFont(12);
    contentTextView.scrollEnabled = NO;
    contentTextView.textContainer.maximumNumberOfLines = 2;
    contentTextView.backgroundColor = [UIColor clearColor];
    [_bottomView addSubview:contentTextView];
    
    UIButton *sureButton = [[UIButton alloc] init];
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.backgroundColor = kCommonGrayColor;
    sureButton.layer.cornerRadius = 4.0;
//    sureButton.enabled = NO;
    [sureButton addTarget:self action:@selector(sureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:sureButton];
    
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
    
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(selectButton.mas_right).offset(10);
        make.top.equalTo(selectButton);
        make.width.equalTo(@220);
        make.height.equalTo(@35);
    }];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(contentTextView.mas_bottom).offset(20);
        make.left.equalTo(self.bottomView).offset(10);
        make.right.equalTo(self.bottomView).offset(-10);
        make.height.equalTo(@44);
    }];
}

- (NSAttributedString *)getContentLabelAttributedText{
    
    NSString *string1 = @"我同意汉生条款和条件，包括：\n";
    NSString *string2 = @"隐私政策，使用条款和可接受的使用政策";
    NSString *string3 = [NSString stringWithFormat:@"%@%@",string1,string2];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string3 attributes:@{NSForegroundColorAttributeName:kCommonGrayColor}];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kLoginTitleColor range:NSMakeRange(string3.length - string2.length, string2.length)];
    [attrStr addAttribute:NSLinkAttributeName value:@"healthservice://" range:NSMakeRange(string3.length - string2.length, string2.length)];

    return attrStr;
}

- (void)selectButtonClicked:(UIButton *)sender{
    
    sender.selected = !sender.selected;
}

- (void)sureButtonClicked{
    
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.row == array.count - 1) {
            
            cell.showImage.hidden = YES;
            cell.contentLabel.textColor = kCommonColor(43, 43, 43, 1);
            
        }else{
            
            cell.showImage.hidden = NO;
            cell.contentLabel.textColor = kLoginTitleColor;
        }
        
        cell.titleLabel.text = array[indexPath.row];
        
        return cell;
        
    }else{
        
        if (indexPath.row == array.count) {
            
            HomeSureInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSureInfoEditCell"];
            if (!cell) {
                
                cell = [[HomeSureInfoEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSureInfoEditCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
            
        }else{
            
            HomeSureInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSureInfoListCell"];
            if (!cell) {
                
                cell = [[HomeSureInfoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSureInfoListCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.showImage.hidden = YES;
            cell.contentLabel.textColor = kCommonColor(43, 43, 43, 1);
            cell.titleLabel.text = array[indexPath.row];
            
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
